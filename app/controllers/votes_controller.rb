class VotesController < ApplicationController

  before_action :authenticate_user!

  respond_to :json

  def create
    nomination = Nomination.find(params[:vote][:nomination_id])
    vote = nomination.votes.build(vote_params)
    vote.save
    if nomination.votes.length == nomination.mission.game.players.length
      nomination.mission.game.advance_king!
      nomination.mission.game.save
    end
    respond_with(vote)
  end

  private
  def vote_params
    nomination = Nomination.find(params[:vote][:nomination_id])
    params.require(:vote).permit(:nomination_id, :pass)
      .merge({
        player_id: Player.where(
          user_id: current_user.id,
          game_id: nomination.mission.game.id).first.id
      })
  end
end
