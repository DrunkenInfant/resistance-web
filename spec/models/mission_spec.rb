require 'spec_helper'

describe Mission do

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
