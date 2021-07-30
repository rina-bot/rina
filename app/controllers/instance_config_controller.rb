class InstanceConfigController < ApplicationController
  before_action :require_login, if: :configured?

  layout 'login'

  def edit; end

  def update
    unless configured?
      if (@admin_user = User.new(form_params[:admin])).valid?
        @admin_user.save!
      else
        render 'edit'
        return
      end
    end

    InstanceConfig.update(form_params[:instance_config])
    redirect_to root_path
  end

  private

  def form_params
    params.require(:form).permit(
      admin: %i[email password],
      instance_config: %i[url_host line_channel_id line_channel_secret line_channel_token]
    )
  end
end
