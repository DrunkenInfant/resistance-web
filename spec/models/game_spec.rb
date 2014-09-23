require 'spec_helper'

describe Game do

  describe "validates" do
    it "validate number of players" do
      game = FactoryGirl.build(:game)
      game.missions = [2,3,2,3,3].map { |n|
        FactoryGirl.build(:mission, nbr_participants: n, game: game)
      }
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
      game.missions = [2,3,2,3,3].map { |n|
        FactoryGirl.build(:mission, nbr_participants: n, game: game)
      }
      5.times { |n|
        game.players << FactoryGirl.build(:player, game: game)
      }
      game.should be_valid
      game.players << FactoryGirl.build(:player, team: "", game: game)
      game.should_not be_valid
    end

    it "validate number of missions" do
      game = FactoryGirl.build(:game)
      5.times { |n|
        game.players << FactoryGirl.build(:player, game: game)
      }
      game.missions = [2,3,2,3].map { |n|
        FactoryGirl.build(:mission, nbr_participants: n, game: game)
      }
      game.should_not be_valid
      game.missions << FactoryGirl.build(:mission, nbr_participants: 3, game: game)
      game.should be_valid
      game.missions << FactoryGirl.build(:mission, nbr_participants: 3, game: game)
      game.should_not be_valid
    end
  end
end
