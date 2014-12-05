require 'spec_helper'

describe NominationsController do

  before(:each) do
    @game = FactoryGirl.build(:game, missions_count: 0)
    @mission = FactoryGirl.build(:mission, game: @game)
    @nomination_attrs = {
      "mission_id" => @mission.id,
      "player_ids" => @game.players[0, @mission.nbr_participants].map { |p| p.id }
    }
    @nomination = FactoryGirl.build(:nomination, mission: @mission)
    Mission.stub(:find).and_return(@mission)
    @user = @game.king.user
    sign_in @user
  end

  describe "POST to NominationsController" do
    it "should create nomination" do
      @mission.nominations.should_receive(:build).with(@nomination_attrs).and_return(@nomination)
      @nomination.should_receive(:save)
      serializer = NominationSerializer.new(@nomination, scope: @user)
      NominationSerializer.should_receive(:new).with(@nomination, anything).and_return(serializer)
      serializer.should_receive(:to_json).and_return({})
      post :create,
        nomination: @nomination_attrs,
        format: :json
      response.status.should be_eql(201)
    end

    it "should not create nomination if it is invalid" do
      @mission.nominations.should_receive(:build).with(@nomination_attrs).and_return(@nomination)
      @nomination.should_receive(:save) { @nomination.errors[:nomination] = "Error_message" }
      post :create,
        nomination: @nomination_attrs,
        format: :json
      response.status.should be_eql(422)
      response.body.should be_json_eql({ errors: { nomination: ["Error_message"] } }.to_json)
    end

    it "should not create nomination if not signed in" do
      @mission.nominations.should_not_receive(:build)
      sign_out @user
      post :create,
        nomination: @nomination_attrs,
        format: :json
      response.status.should be_eql(401)
    end

    it "should not create nomination if user is not king" do
      @game.should_receive(:king).and_return(@game.players[1])
      @mission.nominations.should_not_receive(:build)
      post :create,
        nomination: @nomination_attrs,
        format: :json
      response.status.should be_eql(422)
      response.body.should be_json_eql({ errors: { nomination: ["Only the king may nominate"] } }.to_json)
    end

    it "should not proxy vote accept for all users unless fifth nomination" do
      @mission.nominations.should_receive(:build).with(@nomination_attrs).and_return(@nomination)
      @mission.nominations.stub(:length).and_return(4)
      @nomination.votes.should_not_receive(:create)
      post :create,
        nomination: @nomination_attrs,
        format: :json
      response.status.should be_eql(201)
    end

    it "should proxy vote accept for all users on fifth nomination" do
      @mission.nominations.should_receive(:build).with(@nomination_attrs).and_return(@nomination)
      @nomination.should_receive(:save)
      @mission.nominations.stub(:length).and_return(5)
      @game.players.each do |p|
        @nomination.votes.should_receive(:create).with(player: p, pass: true)
      end
      post :create,
        nomination: @nomination_attrs,
        format: :json
      response.status.should be_eql(201)
    end

    it "should advance king on fifth nomination" do
      @mission.nominations.stub(:length).and_return(5)
      @nomination.votes.stub(:create)

      @mission.nominations.should_receive(:build)
        .with(@nomination_attrs)
        .and_return(@nomination)
      @nomination.should_receive(:save)
      @mission.game.should_receive(:advance_king!)
      @mission.game.should_receive(:save).and_return(true)

      post :create,
        nomination: @nomination_attrs,
        format: :json
      response.status.should be_eql(201)
    end
  end

  describe "GET to NominationsController with :id" do
    it "should return Nomination with id" do
      nomination_id = "5"
      serializer = NominationSerializer.new(@nomination, scope: @user)

      NominationSerializer.should_receive(:new).with(@nomination, anything).and_return(serializer)
      serializer.should_receive(:to_json).and_return({})
      Nomination.should_receive(:find).with(nomination_id).and_return(@nomination)

      get :show, id: nomination_id, format: :json
      response.status.should be_eql(200)
    end
  end
end
