require 'spec_helper'

describe PlayerSerializer do
  it "should not return teams if current user is not player" do
    player = FactoryGirl.build(:player)
    game = FactoryGirl.build(:game, players_count: 0, missions_count: 0)
    game.stub(:find_player_by_user).and_return(nil)
    player.stub(:game).and_return(game)
    user = FactoryGirl.create(:user)
    PlayerSerializer.new(player, scope: user).to_json.should \
      be_json_eql({ player: {
        id: player.id,
        team: ""
      } }.to_json).excluding(:game_id, :name, :user_id).including(:id)
  end
end
