class Achievement < ApplicationRecord
  include Messageable

  has_and_belongs_to_many :players

  has_and_belongs_to_many :granted_by_messages, class_name: "Message", join_table: "message_grant_achievements"

  accepts_nested_attributes_for :messages, allow_destroy: true

  before_save :normalize_keywords

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

  def normalize_keywords
    keywords.reject!(&:blank?)
  end
end
