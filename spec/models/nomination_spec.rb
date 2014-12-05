require 'spec_helper'

describe Nomination do

  describe "validators" do
    before(:each) do
      @mission = FactoryGirl.build(:mission)
      @nomination = FactoryGirl.build(:nomination, mission: @mission, votes: [])
    end

    it "should validate number of players" do
      @nomination.should be_valid
      @mission.stub(:nbr_participants).and_return(1)
      @nomination.should_not be_valid
      @mission.stub(:nbr_participants).and_return(3)
      @nomination.should_not be_valid
    end

    it "should validate mission" do
      @nomination.should be_valid
      @mission.stub(:valid?).and_return(false)
      @nomination.should_not be_valid
    end

    it "should validate one vote per player" do
      @mission.game.players.each do |p|
        @nomination.votes << FactoryGirl.build(:vote, player: p)
      end
      @nomination.should be_valid
      @nomination.votes[1].player = @nomination.votes[0].player
      @nomination.should_not be_valid
    end
  end

end
