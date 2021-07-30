class Scene::WaitRemoteJob < Scene
  store_accessor :meta, :job_channel

  # we don't really need input, but we want to stall until job started
  self.need_input = true

  def start(player)
    super

    remote_job = player.remote_jobs.find_by(channel: job_channel)
    main_phase_finish(player) if remote_job&.finished || remote_job.nil?
  end

  def handle_input(player, text)
  end
end
