
require 'spec_helper'

describe Users::SessionsController do

  describe "POST to SessionController" do
    it "should authenticate user" do
      user = FactoryGirl.create(:user)
      @request.env["devise.mapping"] = Devise.mappings[:user]
      subject.current_user.should be_nil
      post :create, user: {email: user.email, password: "jagkan"}, format: :json
      response.body.should be_json_eql({}.to_json)
      response.status.should eql(204)
      subject.current_user.should_not be_nil
    end
  end

  describe "DELETE to SessionCOntroller" do
    it "should sign out user" do
      user = FactoryGirl.create(:user)
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in user
      subject.current_user.should_not be_nil
      delete :destroy
      response.body.should be_json_eql({}.to_json)
      subject.current_user.should be_nil
    end
  end

  describe "GET to SessionController" do
    it "should return current user" do
      user = FactoryGirl.create(:user)
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in user
      subject.current_user.should_not be_nil
      get :current
      JsonSpec.excluded_keys = []
      response.body.should be_json_eql({user: {id: 'current', email: user.email}}.to_json)
    end

    it "should return nil user" do
      FactoryGirl.create(:user)
      @request.env["devise.mapping"] = Devise.mappings[:user]
      subject.current_user.should be_nil
      get :current
      response.body.should be_json_eql({}.to_json)
      response.status.should eql(404)
    end
  end

end
