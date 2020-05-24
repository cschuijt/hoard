require 'rails_helper'

RSpec.describe "Folders", type: :request do

  before(:each) do
    Rails.application.env_config["devise.mapping"] = Devise.mappings[:user]
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter]
  end

  describe "GET /folders" do
    context "when not logged in" do
      it "should redirect to the login page" do
        get "/folders"

        expect(response).to redirect_to(new_user_session_url)
      end
    end

    context "when logged in" do
      it "should be successful" do
        user = create(:user)
        log_in_as(user)

        get "/folders"

        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "GET /folders/:id" do
    context "on a public folder" do
      it "should be successful" do
        folder = create(:folder)
        get "/folders/#{folder.id}"
        expect(response).to have_http_status(:success)
      end
    end

    context "on a private folder" do
      context "when not logged in" do
        it "should redirect to login page" do
          folder = create(:folder, private: true)
          get "/folders/#{folder.id}"

          expect(response).to redirect_to(new_user_session_url)
        end
      end

      context "when logged in as the correct user" do
        it "should be successful" do
          user = create(:user)
          folder = create(:folder, user: user, private: true)

          log_in_as(user)
          get "/folders/#{folder.id}"

          expect(response).to have_http_status(:success)
        end
      end

      context "when logged in as another user" do
        it "should redirect to folders index" do
          user = create(:user)
          folder = create(:folder, user: user, private: true)

          other_user = create(:user)
          log_in_as(other_user)
          get "/folders/#{folder.id}"

          expect(response).to redirect_to(folders_url)
        end
      end
    end
  end
end
