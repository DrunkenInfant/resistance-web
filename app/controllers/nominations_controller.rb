class NominationsController < ApplicationController

  respond_to :json

  def create
    nomination = Nomination.create(nomination_params)
    respond_with(nomination.mission.game, nomination.mission, nomination)
  end

  private
  def nomination_params
    params.require(:nomination).permit(:mission_id, player_ids: [])
  end
end
