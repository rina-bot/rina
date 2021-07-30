class Scene::EnqueueRemoteJob < Scene
  store_accessor :meta, :job_channel

  # we don't really need input, but we want to stall until job started
  self.need_input = true

  def start(player)
    super

    request_id = SecureRandom.uuid
    player.remote_jobs.find_or_create_by(channel: job_channel) do |remote_job|
      remote_job.request_id = request_id
    end

    Beaneater.new.tubes[job_channel].put(
      JSON.dump(request_id: request_id),
      ttr: 86400
    )
  end

  def handle_input(player, text)
  end
end
