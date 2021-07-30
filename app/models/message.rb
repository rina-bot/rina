class Message < ApplicationRecord
  native_enum :phase

  belongs_to :trigger, polymorphic: true

  # FIXME: bad naming, might not be a flag
  has_and_belongs_to_many :flagged_players, class_name: "Player", join_table: "player_flagged_messages"

  has_and_belongs_to_many :grant_achievements, class_name: "Achievement", join_table: "message_grant_achievements"

  before_save :fill_order

  # if file is attached, text is ignored
  has_one_attached :file

  default_scope ->{ order(order: :asc) }

  def interpolated_text(player)
    text.gsub("%name%", player.name || "")
  end

  # whether given input matches any global keyword
  def keyword_match?(input)
    keywords.any? do |keyword_exp|
      parsed = keyword_exp.match(/\A(?<op>[=^~])?(?<keyword>.*)\z/)

      method = case parsed[:op]
               when "=" then :==
               when "^" then :start_with?
               when "~" then :end_with?
               else :include?
               end

      input.downcase.strip.send(method, parsed[:keyword].downcase)
    end
  end

  def keywords=(new_keywords)
    super new_keywords.reject(&:blank?)
  end

  def delay
    super&.tap {|value| return value }
    return 0 unless text.present?

    [text.bytes.count / 6.0, 5].min
  end

  def fill_order
    self.order = trigger.messages.count + 1 if self.order == 0
  end
end
