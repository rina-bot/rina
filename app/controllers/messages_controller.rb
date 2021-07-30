class MessagesController < ApplicationController
  load_and_authorize_resource :scene
  load_and_authorize_resource through: :scene

  def create
    @message.save!

    redirect_back
  end

  def update
    @message.update!(message_params)

    redirect_back
  end

  def message_params
    params.require(:message).permit!
  end
end
