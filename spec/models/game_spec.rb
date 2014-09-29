require 'spec_helper'

describe Game do

  describe "validates" do
    it "validate number of players" do
      game = FactoryGirl.build(:game, players_count: 0)
      5.times { |n|
        game.should_not be_valid
        game.players << FactoryGirl.build(:player, game: game)
      }
      7.times { |n|
        game.should be_valid
        game.players << FactoryGirl.build(:player, game: game)
      }
      game.should_not be_valid
    end

    it "validate players aswell" do
      game = FactoryGirl.build(:game)
      game.should be_valid
      game.players << FactoryGirl.build(:player, team: "", game: game)
      game.should_not be_valid
    end

    it "validate number of missions" do
      game = FactoryGirl.build(:game, missions_count: 4)
      game.should_not be_valid
      game.missions << FactoryGirl.build(:mission, nbr_participants: 3, game: game)
      game.should be_valid
      game.missions << FactoryGirl.build(:mission, nbr_participants: 3, game: game)
      game.should_not be_valid
    end
  end
end
