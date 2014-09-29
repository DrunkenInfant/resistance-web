
require 'spec_helper'

describe GamesController do

  before(:each) do
    @users = []
    5.times { |n|
      @users << FactoryGirl.create(:user)
    }
  end

  describe "POST to GamesController" do
    it "should create new game" do
      post :create, game: { user_ids: @users.map { |u| u.id } }, format: :json
      response.body.should have_json_path("game")
      response.body.should have_json_path("game/player_ids")
      response.status.should be_eql(201)
      Game.find(parse_json(response.body)["game"]["id"])
    end

    it "should assign teams correctly" do
      7.times do |n|
        post :create, game: { user_ids: @users.map { |u| u.id } }, format: :json
        game = Game.find(parse_json(response.body)["game"]["id"])
        (game.players.select{ |p| p.team == "spies" }).length.should be_eql((@users.length - 1)/2)
        (game.players.select{ |p| p.team == "resistance" }).length.should be_eql(@users.length/2 + 1)
        @users << FactoryGirl.create(:user)
      end
    end

    it "should not create new game with too few players" do
      @users.pop
      post :create, game: { user_ids: @users.map { |u| u.id } }, format: :json
      response.body.should have_json_path("errors")
      response.status.should be_eql(422)
    end

  end

  describe "GET with :id to GamesController" do
    it "should return game" do
      game = FactoryGirl.build(:game)
      game.players = @users.map { |u|
        FactoryGirl.build(:player, user: u, game: game)
      }
      game.missions = [2,3,3,2,3].map { |n|
        FactoryGirl.build(:mission, nbr_participants: n, game: game)
      }
      game.save!
      get :show, id: game.id, format: :json
      expected_json = {
        game: {
          id: game.id,
          player_ids: game.players.map { |p| p.id },
          mission_ids: game.missions.map { |m| m.id }
        },
        players: game.players.map { |p|
          {
            id: p.id,
            game_id: p.game_id,
            user_id: p.user_id,
            team: ""
          }
        },
        missions: game.missions.map { |m|
          {
            id: m.id,
            index: m.index,
            game_id: m.game_id,
            nbr_participants: m.nbr_participants,
            nbr_fails_required: m.nbr_fails_required
          }
        }
      }.to_json
      response.body.should be_json_eql(expected_json)
    end

    it "should return game with only current_user team" do
      game = FactoryGirl.build(:game)
      game.players = @users.map { |u|
        FactoryGirl.build(:player, user: u, game: game)
      }
      game.missions = [2,3,3,2,3].map { |n|
        FactoryGirl.build(:mission, nbr_participants: n, game: game)
      }
      game.save!
      sign_in @users.first
      get :show, id: game.id, format: :json
      expected_json = game.players.map { |p|
        if p.user_id == @users.first.id
          {
            id: p.id,
            game_id: p.game_id,
            user_id: p.user_id,
            team: p.team
          }
        else
          {
            id: p.id,
            game_id: p.game_id,
            user_id: p.user_id,
            team: ""
          }
        end
      }.to_json
      response.body.should include_json(expected_json)
    end

    it "should return 404 if game not found" do
      game = FactoryGirl.build(:game)
      game.players = @users.map { |u|
        FactoryGirl.build(:player, user: u, game: game)
      }
      game.missions = [2,3,3,2,3].map { |n|
        FactoryGirl.build(:mission, nbr_participants: n, game: game)
      }
      game.save!
      get :show, id: game.id + 1, format: :json
      response.body.should be_json_eql({}.to_json)
      response.status.should be_eql(404)
    end
  end

  #describe "GET to GamesController" do
    #it "should return list of all games" do
      #15.times do |n|
        #game = FactoryGirl.build(:game)
        #game.players = @users.map do |u|
          #FactoryGirl.build(:player, game: game, user: u)
        #end
        #game.save!
      #end
      #get :index, format: :json
      #expected_games_json = Game.all.map { |g|
          #{
            #id: g.id,
            #player_ids: g.players.map { |p| p.id }
          #}
      #}.to_json
      #response.body.should include_json(expected_games_json)
    #end
  #end
end
