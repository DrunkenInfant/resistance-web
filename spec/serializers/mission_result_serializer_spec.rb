require 'spec_helper'

describe MissionResultSerializer, type: :controller do

  #include Warden::Test::Helpers
  #Warden.test_mode!

  it "should include success" do
    mission_result = FactoryGirl.build(:mission_result)
    MissionResultSerializer.new(mission_result).to_json.should \
      be_json_eql({ mission_result: {
        id: mission_result.id,
        success: mission_result.success
      } }.to_json).excluding(:mission_id).including(:id)
  end

  it "should include mission_id" do
    mission_result = FactoryGirl.build(:mission_result, mission: FactoryGirl.build(:mission))
    MissionResultSerializer.new(mission_result).to_json.should \
      be_json_eql({ mission_result: {
        id: mission_result.id,
        mission_id: mission_result.mission_id
      } }.to_json).excluding(:success).including(:id)
  end

  it "should include player if current user" do
    user = FactoryGirl.create(:user)
    player = FactoryGirl.build(:player, user: user)
    mission_result = FactoryGirl.build(:mission_result, player: player)

    MissionResultSerializer.new(mission_result, scope: user).to_json.should \
      be_json_eql({ mission_result: {
        id: mission_result.id,
        player_id: player.id,
        success: mission_result.success
      } }.to_json).excluding(:mission_id).including(:id)
  end
end
