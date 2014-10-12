class NominationsController < ApplicationController

  respond_to :json

  def create
    mission = Mission.find(nomination_params[:mission_id])
    nomination = mission.nominations.build(nomination_params)
    nomination.save
    respond_with(nomination)
  end

  def show
    nomination = Nomination.find(params[:id])
    respond_with(nomination)
  end

  private
  def nomination_params
    params.require(:nomination).permit(:mission_id, player_ids: [])
  end
end
