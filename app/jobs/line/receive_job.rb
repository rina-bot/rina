class Line::ReceiveJob < ApplicationJob
  queue_as :default

  def perform(payload)
    Line.client.parse_events_from(payload).each do |event|
      player = Player.find_or_initialize_by(line_uid: event["source"]&.[]("userId"))
      player.update(line_reply_token: event['replyToken'])

      case event
      when Line::Bot::Event::Follow
        player.reset_game
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          player.handle_input event.message['text']
        end
      end
    end
  end
end
