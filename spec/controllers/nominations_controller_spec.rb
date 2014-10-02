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
end
