require 'spec_helper'

describe MissionResultsController do

  before(:each) do
    @game = FactoryGirl.create(:game)
    @mission = @game.missions.first
    @nomination = FactoryGirl.create(:nomination, mission: @mission)
    @nomination.votes = @game.players.map do |p|
      FactoryGirl.create(:vote, player: p, nomination: @nomination)
    end
    @mission.reload
    @user = @game.king.user
    sign_in @user
  end

  describe "POST to MissionResultsController" do
    it "should create mission result" do
      mr = FactoryGirl.attributes_for(:mission_result,
        mission_id: @game.missions.first.id)
      post :create,
        mission_result: mr,
        format: :json
      response.status.should be_eql(201)
      response.body.should have_json_path("mission_result")
      response.body.should_not have_json_path("mission_result/player")
      mro = MissionResult.all.last
      mro.player.user.should eql(@user)
      mro.success.should be_true
    end

    it "should only create mission result for nominated players" do
      sign_out @game.king.user
      @game.players.each do |p|
        sign_in p.user
        mr = FactoryGirl.attributes_for(:mission_result,
          mission_id: @game.missions.first.id)
        post :create,
          mission_result: mr,
          format: :json
        if @nomination.players.include? p
          response.status.should be_eql(201)
          mro = MissionResult.all.last
          mro.player.user.should eql(p.user)
        else
          response.status.should be_eql(422)
          response.body.should have_json_path("errors/player")
          mro = MissionResult.where(player: p, mission: @game.missions.first).first
          mro.should be_nil
        end
        sign_out p.user
      end
    end

    it "should only create one mission result per player" do
      FactoryGirl.create(:mission_result,
                         mission: @mission,
                         player: @nomination.players.first)
      sign_out @user
      sign_in @nomination.players.first.user
      mr = FactoryGirl.attributes_for(:mission_result,
        mission_id: @mission.id)
      post :create,
        mission_result: mr,
        format: :json
      response.status.should be_eql(422)
      response.body.should have_json_path("errors/mission")
    end
  end
end
