require 'spec_helper'

describe Game do

  describe "validates" do
    it "validate number of players" do
      game = FactoryGirl.build(:game, players_count: 1)
      4.times { |n|
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

  describe "advance game" do
    it "advance king should set next player as king" do
      game = FactoryGirl.build(:game)
      game.king.should be_eql(game.players[0])
      game.king_id.should be_eql(game.players[0].id)
      game.advance_king!
      game.king.should be_eql(game.players[1])
      game.king_id.should be_eql(game.players[1].id)
      game.advance_king!
      game.king.should be_eql(game.players[2])
      game.king_id.should be_eql(game.players[2].id)
      game.advance_king!
      game.king.should be_eql(game.players[3])
      game.king_id.should be_eql(game.players[3].id)
      game.advance_king!
      game.king.should be_eql(game.players[4])
      game.king_id.should be_eql(game.players[4].id)
      game.advance_king!
      game.king.should be_eql(game.players[0])
      game.king_id.should be_eql(game.players[0].id)
    end
  end
end
