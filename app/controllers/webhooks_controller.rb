class WebhooksController < ActionController::API
  def line
    Line::ReceiveJob.perform_later(request.body.read.force_encoding("UTF-8"))
  end
end
