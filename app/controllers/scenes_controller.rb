class ScenesController < ApplicationController
  load_and_authorize_resource

  def index
  end

  def new
  end

  def create
    @scene.save!

    redirect_to scenes_path
  end

  def update
    @scene.update!(scene_params)

    redirect_to scenes_path
  end

  def destroy
    @scene.destroy!

    redirect_back
  end

  def scene_params
    params.require(:scene).permit!
  end
end
