class NominationsController < ApplicationController

  before_action :authenticate_user!

  respond_to :json

  def create
    mission = Mission.find(nomination_params[:mission_id])
    if current_user == mission.game.king.user
      nomination = mission.nominations.build(nomination_params)
      nomination.save
      if mission.nominations.length == 5
        mission.game.players.each { |p|
          nomination.votes.create(player: p, pass: true)
        }
      end
      respond_with(nomination)
    else
      render json: { errors: { nomination: ["Only the king may nominate"] } },
        status: 422
    end
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
