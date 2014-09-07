
require 'spec_helper'

describe Users::RegistrationsController do

  describe "POST to RegistrationsController" do
    it "should create new user" do
      user = FactoryGirl.attributes_for(:user)
      @request.env["devise.mapping"] = Devise.mappings[:user]
      post :create, user: user, format: :json
      response.body.should have_json_path("email")
      response.body.should have_json_path("id")
      parse_json(response.body)["email"].should be_eql(user[:email])
      response.status.should eql(201)
      subject.current_user.should be_nil
    end
  end

  describe "GET with :id to RegistrationsController" do
    it "should return user" do
      user = FactoryGirl.create(:user)
      @request.env["devise.mapping"] = Devise.mappings[:user]
      get :show, id: user.id, format: :json
      JsonSpec.exclude_keys "created_at", "updated_at"
      response.body.should be_json_eql({user: {id: user.id, email: user.email}}.to_json)
    end

    it "should return satus 404 if id does not exist" do
      user = FactoryGirl.create(:user)
      @request.env["devise.mapping"] = Devise.mappings[:user]
      id = user.id + 1
      get :show, id: id, format: :json
      response.body.should be_json_eql({}.to_json)
    end
  end

end
