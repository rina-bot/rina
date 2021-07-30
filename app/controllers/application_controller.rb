class ApplicationController < ActionController::Base
  include Clearance::Controller

  delegate :configured?, to: InstanceConfig

  rescue_from CanCan::AccessDenied do |e|
    if current_user
      redirect_to root_path, error: e.message
    else
      redirect_to sign_in_path
    end
  end

  before_action unless: :configured? do
    next if self.is_a?(InstanceConfigController)

    redirect_to edit_instance_config_path
  end

  def current_ability
    @ability ||= Ability.new(current_user)
  end

  def redirect_back(*args, **kwargs)
    super(*args, fallback_location: root_path, **kwargs)
  end
end
