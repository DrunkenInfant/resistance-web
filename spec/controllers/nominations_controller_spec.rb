require 'spec_helper'

describe NominationsController do

  before(:each) do
    @game = FactoryGirl.create(:game)
    @user = @game.king.user
    sign_in @user
  end

  describe "POST to NominationsController" do
    it "should create nomination" do
      nomination = FactoryGirl.attributes_for(:nomination,
        mission_id: @game.missions.first.id,
        player_ids:
          @game.players[0, @game.missions.first.nbr_participants].map { |p|
            p.id
          })
      post :create,
        nomination: nomination,
        format: :json
      response.status.should be_eql(201)
      nom = Nomination.find(parse_json(response.body)["nomination"]["id"])
      nom.players.to_a.should eql(@game.players[0, 2])
    end

    it "should not create nomination if one is not voted on" do
      nom1 = FactoryGirl.create(:nomination,
          mission: @game.missions.first)
      nom_attr = FactoryGirl.attributes_for(:nomination,
        mission_id: @game.missions.first.id,
        player_ids: @game.players[0, 2].map { |p| p.id })
      post :create,
        nomination: nom_attr,
        format: :json
      response.status.should be_eql(422)
      response.body.should have_json_path("errors/nomination")
      nom1.votes = @game.players.map { |p|
        FactoryGirl.create(:vote, nomination: nom1, player: p)
      }
      post :create,
        nomination: nom_attr,
        format: :json
      response.status.should be_eql(201)
    end

    it "should not create a sixth nomination" do
      5.times {
        nom = FactoryGirl.create(:nomination,
            mission: @game.missions.first)
        @game.players.each { |p|
          FactoryGirl.create(:vote, nomination: nom, player: p)
        }
      }
      nom_attr = FactoryGirl.attributes_for(:nomination,
        mission_id: @game.missions.first.id)
      post :create,
        nomination: nom_attr,
        format: :json
      response.status.should be_eql(422)
      response.body.should have_json_path("errors/mission")
    end

    it "should not create nomination if not signed in" do
      nomination = FactoryGirl.attributes_for(:nomination,
        mission_id: @game.missions.first.id,
        player_ids: @game.players[0, 2].map { |p| p.id })
      sign_out @user
      post :create,
        nomination: nomination,
        format: :json
      response.status.should be_eql(401)
    end

    it "should not create nomination if user is not king" do
      @game.advance_king!
      @game.save
      nomination = FactoryGirl.attributes_for(:nomination,
        mission_id: @game.missions.first.id,
        player_ids: @game.players[0, 2].map { |p| p.id })
      post :create,
        nomination: nomination,
        format: :json
      response.status.should be_eql(422)
      response.body.should have_json_path("errors/nomination")
    end

    it "should proxy vote accept for all users on fifth nomination" do
      4.times do
        nom = FactoryGirl.create(:nomination,
          mission_id: @game.missions.first.id)
        @game.players.each { |p|
          FactoryGirl.create(:vote,
            nomination: nom,
            player: p,
            pass: false)
        }
      end
      nomination = FactoryGirl.attributes_for(:nomination,
        mission_id: @game.missions.first.id,
        player_ids: @game
          .players[0, @game.missions.first.nbr_participants]
          .map { |p| p.id })
      post :create,
        nomination: nomination,
        format: :json
      response.status.should be_eql(201)
      nom = Nomination.find(parse_json(response.body)["nomination"]["id"])
      nom.votes.length.should eql(@game.players.length)
      (nom.votes.map { |v| v.player.id }).should be_eql(
        @game.players.map { |p| p.id })
      nom.votes.each { |v|
        v.pass.should be_true
      }
    end

    it "should only allow correct number of nominated players" do
      nomination = FactoryGirl.attributes_for(:nomination,
        mission_id: @game.missions.first.id,
        player_ids: [])
      @game.players.each do |p|
        if nomination[:player_ids].length != @game.missions.first.nbr_participants
          post :create,
            nomination: nomination,
            format: :json
          response.status.should eql(422)
          response.body.should have_json_path("errors/players")
        end
        nomination[:player_ids] << p.id
      end
      nomination[:player_ids] = @game
        .players[0, @game.missions.first.nbr_participants]
        .map { |p| p.id }
      post :create,
        nomination: nomination,
        format: :json
      response.status.should eql(201)
      Nomination.find(parse_json(response.body)["nomination"]["id"])
    end
  end

  describe "GET to NominationsController with :id" do
    it "should return Nomination with id" do
      nomination = FactoryGirl.create(:nomination,
          mission: @game.missions.first)
      get :show, id: nomination.id, format: :json
      expected_json = {
        nomination: {
          id: nomination.id,
          mission_id: nomination.mission_id,
          player_ids: @game
            .players[0, @game.missions.first.nbr_participants]
            .map { |p| p.id }
        },
      }
      response.body.should be_json_eql(expected_json.to_json)
    end

    it "should withhold votes unless vote is completed" do
      nomination = FactoryGirl.create(:nomination,
          mission: @game.missions.first)
      get :show, id: nomination.id, format: :json
      expected_json = {
        nomination: {
          id: nomination.id,
          mission_id: nomination.mission_id,
          player_ids: @game
            .players[0, @game.missions.first.nbr_participants]
            .map { |p| p.id }
        },
      }
      response.body.should be_json_eql(expected_json.to_json)
      @game.players.each { |p|
        FactoryGirl.create(:vote, nomination: nomination, player: p)
        nomination.reload
        if nomination.votes.length == @game.players.length
          expected_json[:nomination][:vote_ids] = nomination.votes.map { |v|
            v.id
          }
        end
        get :show, id: nomination.id, format: :json
        response.body.should be_json_eql(expected_json.to_json)
      }
    end
  end
end
