require 'spec_helper'

describe Mission do

  describe "validator" do
    before(:each) do
      @mission = FactoryGirl.build(:mission)
    end

    it "should not validate if more than one nomination is not voted on" do
      @mission.should be_valid
      @mission.nominations << FactoryGirl.build(:nomination, mission: @mission, votes: [])
      @mission.should be_valid
      @mission.nominations << FactoryGirl.build(:nomination, mission: @mission, votes: [])
      @mission.should_not be_valid
      @mission.game.players.each do |p|
        @mission.nominations.first.votes << FactoryGirl.build(:vote, player: p)
      end
      @mission.should be_valid
    end

    it "should not validate more than five nominations" do
      @mission.should be_valid
      votes = @mission.game.players.map { |p| FactoryGirl.build(:vote, player: p) }
      5.times do
        @mission.nominations << FactoryGirl.build(:nomination, mission: @mission, votes: votes)
        @mission.should be_valid
      end
      @mission.nominations << FactoryGirl.build(:nomination, mission: @mission, votes: votes)
      @mission.should_not be_valid
    end
  end

  describe "passed_nomination" do
    it "should only return passed nomination or nil" do
      game = FactoryGirl.create(:game)
      mission = game.missions.first
      mission.nominations << FactoryGirl.create(:nomination, mission: mission)
      nomination = mission.nominations.first
      game.players.each { |p|
        mission.passed_nomination.should be_nil
        nomination.votes << FactoryGirl.create(:vote, player: p, nomination: nomination)
      }
      mission.passed_nomination.should be_eql(nomination)
      nomination.votes = game.players.map do |p|
        FactoryGirl.create(:vote, player: p, nomination: nomination, pass: false)
      end
      mission.passed_nomination.should be_nil
      nomination.votes[0].pass = true
      mission.passed_nomination.should be_nil
      nomination.votes[1].pass = true
      mission.passed_nomination.should be_nil
      nomination.votes[2].pass = true
      mission.passed_nomination.should be_eql(nomination)
      nomination.votes[3].pass = true
      mission.passed_nomination.should be_eql(nomination)
      nomination.votes[4].pass = true
      mission.passed_nomination.should be_eql(nomination)
    end
  end

end
