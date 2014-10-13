class GamesController < ApplicationController

  respond_to :json

  def index
    respond_with(Game.all)
  end

  def show
    game = Game.find_by_id(params[:id])
    if game
      respond_with(game)
    else
      render json: {}, status: :not_found
    end
  end

  def create
    nbr_players = game_params[:user_ids].length
    members = team_assignments(nbr_players).shuffle
    game = Game.create do |g|
      g.players = game_params[:user_ids].map { |uid|
        Player.new user_id: uid, game: g, team: members.pop
      }
      g.missions = mission_specs(nbr_players).map { |ms|
        Mission.new nbr_participants: ms[:participants], nbr_fails_required: ms[:fails], game: g
      }
      g.king = g.players.first
    end
    respond_with(game)
  end

  private
    def game_params
      params.require(:game).permit(user_ids: [])
    end

    def team_assignments (nbr_players)
      nbr_spies = (nbr_players-1)/2
      spies = Array.new(nbr_spies, "spies")
      resistance = Array.new(nbr_players - nbr_spies, "resistance")
      return spies + resistance
    end

    def mission_specs (nbr_players)
      [
        { participants: 2, fails: 1},
        { participants: 3, fails: 1},
        { participants: 2, fails: 1},
        { participants: 3, fails: 1},
        { participants: 3, fails: 1}
      ]
    end
end
