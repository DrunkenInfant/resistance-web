require 'spec_helper'

describe VotesController do
  describe "POST to VotesController" do
    before(:each) do
      @game = FactoryGirl.create(:game)
      @nomination = FactoryGirl.create(:nomination,
        mission_id: @game.missions.first.id,
        player_ids: @game.players[0, 2].map { |p| p.id }
      )
    end

    it "should create passing vote for current user" do
      sign_in @game.players.first.user
      @nomination.votes.length.should be_eql(0)
      post :create, vote: { nomination_id: @nomination.id, pass: true },
        format: :json
      response.status.should be_eql(201)
      @nomination.reload
      @nomination.votes.length.should be_eql(1)
      vote = @nomination.votes.first
      vote.player.should eql(@game.players.first)
      vote.pass.should be_eql(true)
    end

    it "should create rejecting vote for current user" do
      sign_in @game.players.first.user
      @nomination.votes.length.should be_eql(0)
      post :create, vote: { nomination_id: @nomination.id, pass: false },
        format: :json
      response.status.should be_eql(201)
      @nomination.reload
      @nomination.votes.length.should be_eql(1)
      vote = @nomination.votes.first
      vote.player.should eql(@game.players.first)
      vote.pass.should be_eql(false)
    end

    it "should respond with status 401 if user is not signed in" do
      @nomination.votes.length.should be_eql(0)
      post :create, vote: { nomination_id: @nomination.id, pass: true },
        format: :json
      response.status.should be_eql(401)
      @nomination.reload
      @nomination.votes.length.should be_eql(0)
    end

    it "should respond with status 422 if user has already voted" do
      FactoryGirl.create(:vote,
        nomination: @nomination,
        player: @game.players.first)
      @nomination.reload
      @nomination.votes.length.should be_eql(1)
      sign_in @game.players.first.user
      post :create, vote: { nomination_id: @nomination.id, pass: true },
        format: :json
      response.status.should be_eql(422)
      response.body.should have_json_path("errors/votes")
      @nomination.reload
      @nomination.votes.length.should be_eql(1)
    end

    it "should advance king on last vote" do
      @game.players[1..-1].each { |p|
        FactoryGirl.create(:vote,
          nomination: @nomination,
          player: p,
          pass: true)
      }
      @nomination.reload
      @game.king.should be_eql(@game.players.first)
      sign_in @game.players.first.user
      post :create, vote: { nomination_id: @nomination.id, pass: true },
        format: :json
      @game.reload
      @game.king.should be_eql(@game.players[1])
    end
  end
end
