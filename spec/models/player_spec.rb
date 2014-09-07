require 'spec_helper'

describe Player do
  describe "validates" do
    it "validate team" do
      FactoryGirl.build(:player, team: "resistance").should be_valid
      FactoryGirl.build(:player, team: "spies").should be_valid
      FactoryGirl.build(:player, team: "").should_not be_valid
      FactoryGirl.build(:player, team: "foo").should_not be_valid
    end

    it "validate game" do
      FactoryGirl.build(:player, game: game).should be_valid
      FactoryGirl.build(:player, game: nil).should_not be_valid
      FactoryGirl.build(:player, game_id: game.id+1).should_not be_valid
    end
  end
end
