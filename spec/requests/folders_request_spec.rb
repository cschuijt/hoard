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

  describe "GET /folders/new" do
    context "when not logged in" do
      it "should redirect to login page" do
        get "/folders/new"

        expect(response).to redirect_to(new_user_session_url)
      end
    end

    context "when logged in" do
      it "should be successful" do
        user = create(:user)
        log_in_as user

        get "/folders/new"

        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "POST /folders/create" do
    context "when not logged in" do
      it "should redirect to login page" do
        post "/folders"

        expect(response).to redirect_to(new_user_session_url)
      end
    end

    context "when submitting valid data" do
      it "should redirect to show" do
        user = create(:user)
        log_in_as user

        post "/folders", params: { folder: attributes_for(:folder) }

        expect(response).to have_http_status(:redirect)
      end
    end

    context "when submitting invalid data" do
      it "should render the new page" do
        log_in_as create(:user)

        post "/folders", params: { folder: attributes_for(:folder, title: "") }

        expect(response).not_to be_a_new(Folder)
      end
    end
  end

  describe "GET /folders/:id/edit" do
    context "when not logged in" do
      it "should redirect to login page" do
        folder = create(:folder)
        get "/folders/#{folder.id}/edit"

        expect(response).to redirect_to(new_user_session_url)
      end
    end

    context "when logged in as another user" do
      it "should redirect to folders index" do
        folder = create(:folder)
        user = create(:user)

        log_in_as(user)
        get "/folders/#{folder.id}/edit"

        expect(response).to redirect_to(folders_url)
      end
    end

    context "when logged in as the correct user" do
      it "should be successful" do
        user = create(:user)
        folder = create(:folder, user: user)

        log_in_as user
        get "/folders/#{folder.id}/edit"

        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "PATCH /folders/:id" do
    context "when not logged in" do
      it "should redirect to login page" do
        folder = create(:folder)
        patch "/folders/#{folder.id}"

        expect(response).to redirect_to(new_user_session_url)
      end
    end

    context "when logged in as someone else" do
      it "should redirect to folders" do
        folder = create(:folder, title: "uwuuuu")
        log_in_as create(:user)

        patch "/folders/#{folder.id}", params: { folder: attributes_for(:folder) }

        expect(response).to redirect_to(folders_url)
      end
    end

    context "with valid data" do
      it "should be successful" do
        user = create(:user)
        folder = create(:folder, user: user)
        log_in_as user

        patch "/folders/#{folder.id}", params: { folder: attributes_for(:folder, title: "Hewwo") }

        expect(response).to redirect_to(folder_url(folder.id))
      end
    end

    context "with invalid data" do
      it "should render edit" do
        user = create(:user)
        folder = create(:folder, user: user)
        log_in_as user

        patch "/folders/#{folder.id}", params: { folder: attributes_for(:folder, title: "") }

        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "DELETE /folders/:id" do
    context "when not logged in" do
      it "should redirect to login page" do
        folder = create(:folder)

        delete "/folders/#{folder.id}"

        expect(response).to redirect_to(new_user_session_url)
      end
    end

    # There is no functional difference between the two assertations here,
    # they both test for a redirect to the folders index. Find a way to
    # make these tests more meaningful! TODO

    context "when logged in as someone else" do
      it "should redirect to folders" do
        folder = create(:folder)
        log_in_as create(:user)

        delete "/folders/#{folder.id}"

        expect(response).to redirect_to(folders_url)
      end
    end

    context "when logged in as the right user" do
      it "should succeed" do
        user = create(:user)
        folder = create(:folder, user: user)

        log_in_as user

        delete "/folders/#{folder.id}"

        expect(response).to redirect_to(folders_url)
      end
    end
  end
end
