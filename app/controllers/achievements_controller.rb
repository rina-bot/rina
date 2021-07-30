class AchievementsController < ApplicationController
  load_and_authorize_resource

  def create
    @achievement.save!

    redirect_back
  end

  def update
    @achievement.update!(achievement_params)

    redirect_back
  end

  def destroy
    @achievement.destroy!

    redirect_back
  end

  def achievement_params
    params.require(:achievement).permit!
  end
end
