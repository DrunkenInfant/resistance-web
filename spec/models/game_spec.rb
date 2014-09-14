require 'spec_helper'

describe Game do

  describe "validates" do
    it "validate number of players" do
      game = FactoryGirl.build(:game)
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
      5.times { |n|
        game.players << FactoryGirl.build(:player, game: game)
      }
      game.should be_valid
      game.players << FactoryGirl.build(:player, team: "", game: game)
      game.should_not be_valid
    end
  end
end
