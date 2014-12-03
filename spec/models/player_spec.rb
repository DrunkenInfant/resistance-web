require 'spec_helper'

describe Player do
  describe "validates" do
    it "validate team" do
      FactoryGirl.build(:player_with_game, team: "resistance").should be_valid
      FactoryGirl.build(:player_with_game, team: "spies").should be_valid
      FactoryGirl.build(:player_with_game, team: "").should_not be_valid
      FactoryGirl.build(:player_with_game, team: "foo").should_not be_valid
    end

    it "validate game" do
      game = FactoryGirl.build(:game)
      FactoryGirl.build(:player, game: game).should be_valid
      FactoryGirl.build(:player, game: nil).should_not be_valid
      FactoryGirl.build(:player, game_id: game.id+1).should_not be_valid
    end
  end
end
