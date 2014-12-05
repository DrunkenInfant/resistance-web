require 'spec_helper'

describe VoteSerializer do

  before(:each) do
    @player = FactoryGirl.build(:player)
    @nomination = FactoryGirl.build(:nomination, mission: nil)
    @vote = FactoryGirl.build(:vote, player: @player, nomination: @nomination)
  end

  it "should include player" do
    VoteSerializer.new(@vote, scope: @player.user).to_json.should \
      be_json_eql({ vote: {
        id: @vote.id,
        player_id: @player.id
      } }.to_json).excluding(:nomination_id, :pass).including(:id)
  end

  it "should include nomination" do
    VoteSerializer.new(@vote, scope: @player.user).to_json.should \
      be_json_eql({ vote: {
        id: @vote.id,
        nomination_id: @nomination.id
      } }.to_json).excluding(:player_id, :pass).including(:id)
  end

  it "should include pass if scope is player and vote is not complete" do
    @nomination.stub(:vote_complete?).and_return(false)
    VoteSerializer.new(@vote, scope: @player.user).to_json.should \
      be_json_eql({ vote: {
        id: @vote.id,
        pass: @vote.pass
      } }.to_json).excluding(:player_id, :nomination_id).including(:id)
  end

  it "should include pass if scope is player and vote is complete" do
    @nomination.stub(:vote_complete?).and_return(true)
    VoteSerializer.new(@vote, scope: @player.user).to_json.should \
      be_json_eql({ vote: {
        id: @vote.id,
        pass: @vote.pass
      } }.to_json).excluding(:player_id, :nomination_id).including(:id)
  end

  it "should include pass if scope is not player but vote is complete" do
    @nomination.stub(:vote_complete?).and_return(true)
    VoteSerializer.new(@vote, scope: FactoryGirl.build(:user)).to_json.should \
      be_json_eql({ vote: {
        id: @vote.id,
        pass: @vote.pass
      } }.to_json).excluding(:player_id, :nomination_id).including(:id)
  end

  it "should include pass if no scope but vote is complete" do
    @nomination.stub(:vote_complete?).and_return(true)
    VoteSerializer.new(@vote, scope: nil).to_json.should \
      be_json_eql({ vote: {
        id: @vote.id,
        pass: @vote.pass
      } }.to_json).excluding(:player_id, :nomination_id).including(:id)
  end

  it "should not include pass if scope is not player and vote is not complete" do
    @nomination.stub(:vote_complete?).and_return(false)
    VoteSerializer.new(@vote, scope: FactoryGirl.build(:user)).to_json.should \
      be_json_eql({ vote: {
        id: @vote.id
      } }.to_json).excluding(:player_id, :nomination_id).including(:id)
  end

  it "should not include pass if no scope and vote is not complete" do
    @nomination.stub(:vote_complete?).and_return(false)
    VoteSerializer.new(@vote, scope: nil).to_json.should \
      be_json_eql({ vote: {
        id: @vote.id
      } }.to_json).excluding(:player_id, :nomination_id).including(:id)
  end

  #it "should include mission_id" do
    #mission_result = FactoryGirl.build(:mission_result, mission: FactoryGirl.build(:mission))
    #VoteSerializer.new(mission_result).to_json.should \
      #be_json_eql({ mission_result: {
        #id: mission_result.id,
        #mission_id: mission_result.mission_id
      #} }.to_json).excluding(:success).including(:id)
  #end

  #it "should include player if current user" do
    #user = FactoryGirl.create(:user)
    #player = FactoryGirl.build(:player, user: user)
    #mission_result = FactoryGirl.build(:mission_result, player: player)

    #VoteSerializer.new(mission_result, scope: user).to_json.should \
      #be_json_eql({ mission_result: {
        #id: mission_result.id,
        #player_id: player.id,
        #success: mission_result.success
      #} }.to_json).excluding(:mission_id).including(:id)
  #end
end
