require 'spec_helper'

describe NominationsController do
  describe "POST to NominationsController" do
    it "should create nomination" do
      game = FactoryGirl.create(:game)
      nomination = FactoryGirl.attributes_for(:nomination,
        mission_id: game.missions.first.id,
        player_ids: game.players[0, 2].map { |p| p.id })
      post :create, game_id: game.id, mission_id: game.missions.first.id,
        nomination: nomination,
        format: :json
      response.status.should be_eql(201)
      nom = Nomination.find(parse_json(response.body)["nomination"]["id"])
      nom.players.to_a.should eql(game.players[0, 2])
    end
  end

  describe "GET to NominationsController with :id" do
    it "should return Nomination with id" do
      game = FactoryGirl.create(:game)
      nomination = FactoryGirl.create(:nomination,
          mission: game.missions.first,
          players: game.players[0,3])
      get :show, id: nomination.id, format: :json
      expected_json = {
        nomination: {
          id: nomination.id,
          mission_id: nomination.mission_id,
          player_ids: game.players[0, 3].map { |p| p.id }
        }
      }.to_json
      response.body.should be_json_eql(expected_json)
    end
  end
end
