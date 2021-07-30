class Scene::WaitFlag < Scene
  self.need_input = true
  store_accessor :meta, :required_flags_count

  def required_flags_count
    super || 1
  end

  def required_flags_count=(new_value)
    super(new_value.to_i)
  end

  def handle_input(player, input)
    responded = false
    catch_all = nil
    after_delay = 0

    messages.keyword.each do |keyword_message|
      # empty keyword = catch all
      if keyword_message.keywords == []
        catch_all = keyword_message
        next
      end

      next unless keyword_message.keyword_match?(input)

      # FIXME: this is not `flagged`_messages, it's all fired keyword message
      player.flagged_messages << keyword_message
      player.send_messages_async [keyword_message]
      after_delay = keyword_message.delay if after_delay < keyword_message.delay
      responded = true
    end

    player.not_acquired_achievement.each do |achievement|
      next unless achievement.keyword_match?(input)

      player.achievements << achievement
      after_delay += achievement.messages.after.map(&:delay).sum
      responded = true
    end

    if !responded && catch_all
      player.flagged_messages << catch_all

      player.send_messages_async [catch_all]
      after_delay += catch_all.delay
    end

    if messages.keyword.where(flag: true).where(id: player.flagged_messages).count == required_flags_count
      main_phase_finish(player, phase: "after", extra_delay: after_delay)
    end
  end
end
