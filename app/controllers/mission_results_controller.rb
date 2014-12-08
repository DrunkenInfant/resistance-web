class MissionResultsController < ApplicationController

  respond_to :json

  def create
    mission = Mission.find(mission_result_params[:mission_id])
    mr = mission.mission_results.build(mission_result_params.merge({
        player: Player.where(
          user_id: current_user.id,
          game_id: mission.game.id).first
    }))
    mr.save
    push_game_update(mission.game)
    respond_with(mr)
  end

  private
  def mission_result_params
    params.require(:mission_result).permit(:mission_id, :success)
  end

end
