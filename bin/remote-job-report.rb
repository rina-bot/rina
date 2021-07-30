#!/usr/bin/env ruby
require_relative "../config/environment"

beaneater = Beaneater.new

beaneater.tubes.watch! "remote-job-started", "remote-job-completed"

loop do
  break unless (report_job = beaneater.tubes.reserve)

  job_body = JSON.parse(report_job.body)
  next unless (remote_job = RemoteJob.find_by(request_id: job_body["request_id"]))

  player = remote_job.player

  case report_job.tube
  when "remote-job-started"
    next unless player.current_scene.is_a?(Scene::EnqueueRemoteJob)

    remote_job.update(started: true)
    player.current_scene.send_messages(player, phase: "after")
  when "remote-job-completed"
    remote_job.update(finished: true)

    if job_body["video"]
      #FIXME: lazy code
      player.line_reply_or_push_message(
        type: "video",
        originalContentUrl: Rails.application.routes.url_helpers.root_url + "video/" + remote_job.request_id,
        previewImageUrl: Rails.application.routes.url_helpers.root_url + "video/thumbnail.png"

      )
    end

    if player.current_scene.is_a?(Scene::WaitRemoteJob)
      player.current_scene.main_phase_finish(player)
    end
  end
ensure
  report_job.bury if report_job&.exists? && report_job.reserved?
end
