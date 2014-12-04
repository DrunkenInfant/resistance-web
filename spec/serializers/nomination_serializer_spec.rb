require 'spec_helper'

describe NominationSerializer do

  before(:each) do
    @nomination = FactoryGirl.build(:nomination,
      mission: FactoryGirl.build(:mission,
        game: FactoryGirl.build(:game, missions_count: 0)
      )
    )
  end

  it "should include mission" do
    NominationSerializer.new(@nomination).to_json.should \
      be_json_eql({ nomination: {
        id: @nomination.id,
        mission_id: @nomination.mission.id
      } }.to_json).excluding(:vote_ids, :player_ids, :votes).including(:id)
  end

  it "should include players" do
    NominationSerializer.new(@nomination).to_json.should \
      be_json_eql({ nomination: {
        id: @nomination.id,
        player_ids: @nomination.players.map { |p| p.id }
      } }.to_json).excluding(:vote_ids, :mission_id, :votes).including(:id)
  end

  it "should include votes" do
    @nomination.votes << FactoryGirl.build(:vote)
    @nomination.votes << FactoryGirl.build(:vote)
    @nomination.votes << FactoryGirl.build(:vote)
    json = NominationSerializer.new(@nomination).to_json
    json.should \
      be_json_eql({
        nomination: {
          id: @nomination.id,
          vote_ids: @nomination.votes.map { |v| v.id }
        }
      }.to_json).excluding(:player_ids, :mission_id, :votes).including(:id)
    json.should have_json_path("votes")
  end
end
