class Line::SendJob < ApplicationJob
  queue_as :default

  # send message from player's current scene
  # (if scene given in job argument mismatch, it's consider out of date and not sent)
  def perform(player: , scene: nil, phase: "main", messages:)
    if scene && scene.id != player.current_scene_id
      Railg.logger.info "job outdated, skip"
      return
    end

    if (message = messages.shift)
      sleep message.delay % 1
      player.send_message message

      if messages.any?
        Line::SendJob
          .set(wait: messages[0].delay.floor)
          .perform_later(player: player, scene: scene, phase: phase, messages: messages)

        return
      end
    end

    return if scene&.class&.need_input && phase == "main"

    # no more messages to send, no need input, go next step
    case phase
    when "main"
      scene.main_phase_finish(player)
    when "after"
      player.next_scene
    end
  end
end
