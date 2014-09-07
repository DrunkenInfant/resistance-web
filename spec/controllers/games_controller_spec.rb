
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
      response.body.should have_json_path("game/players")
      response.status.should be_eql(201)
      Game.find(parse_json(response.body)["game"]["id"])
    end

    it "should assign teams correctly" do
      7.times do |n|
        post :create, game: { user_ids: @users.map { |u| u.id } }, format: :json
        response.body.should have_json_path("game/players")
        response.status.should be_eql(201)
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
      game.save!
      get :show, id: game.id, format: :json
      response.body.should be_json_eql(game.to_json)
    end

    it "should return 404 if game not found" do
      game = FactoryGirl.build(:game)
      game.players = @users.map { |u|
        FactoryGirl.build(:player, user: u, game: game)
      }
      game.save!
      get :show, id: game.id + 1, format: :json
      response.body.should be_json_eql({}.to_json)
      response.status.should be_eql(404)
    end
  end
end
