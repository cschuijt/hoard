require 'rails_helper'

RSpec.describe "Folders", type: :request do

  before(:each) do
    Rails.application.env_config["devise.mapping"] = Devise.mappings[:user]
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter]
  end

  describe "index page" do
    context "when not logged in" do
      it "should redirect to the login page" do
        get "/folders"

        expect(response).to redirect_to(:new_user_session)
      end
    end

    context "when logged in" do
      it "should be accessible" do
        user = create(:user)
        log_in_as(user)

        get "/folders"

        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "show public folder" do
    it "should be successful" do
      folder = create(:folder)
      get "/folders/#{folder.id}"
      expect(response).to have_http_status(:success)
    end
  end
end
