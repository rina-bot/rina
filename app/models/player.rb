class Player < ApplicationRecord
  belongs_to :current_scene, class_name: "Scene", optional: true

  has_many :remote_jobs

  has_and_belongs_to_many :achievements, after_add: :after_new_achievement
  has_and_belongs_to_many :flagged_messages, class_name: "Message", join_table: "player_flagged_messages"

  def send_message(message)
    send_message_to_line(message) if line_uid?

    achievements.concat(message.grant_achievements.where.not(id: achievements))
  end

  def send_message_to_line(message)
    line_message =
      if message.text.present?
        { type: "text", text: message.interpolated_text(self) }
      elsif message.file.image?
        url = Rails.application.routes.url_helpers.polymorphic_url(message.file)
        { type: "image", originalContentUrl: url, previewImageUrl: url }
      end

    return if line_message.nil?

    line_reply_or_push_message(line_message)
  end

  def handle_input(input)
    current_scene&.handle_input(self, input)
  end

  # these messages does not affect current scene
  def send_messages_async(messages)
    Line::SendJob.set(wait: messages[0].delay.floor).perform_later(
      player: self, scene: nil, phase: nil, messages: messages.to_a
    )
  end

  def reset_game
    flagged_messages.clear
    remote_jobs.destroy_all

    update(current_scene: Scene.first)

    current_scene&.start(self)
  end

  def next_scene
    update(current_scene: Scene.where('"order" >= ?', current_scene.order).where.not(id: current_scene.id).first)

    current_scene&.start(self)
  end

  def not_acquired_achievement
    Achievement.where.not(id: achievements)
  end

  def after_new_achievement(achievement)
    send_messages_async achievement.messages.after
  end

  def line_reply_or_push_message(*line_messages)
    if line_reply_token
      response = Line.client.reply_message(
        line_reply_token,
        line_messages
      )

      update(line_reply_token: nil)
      return if response.code == "200"
    end

    response = Line.client.push_message(line_uid, line_messages)
    raise "Failed to send, error: #{response.body}" if response.code != "200"
  end
end
