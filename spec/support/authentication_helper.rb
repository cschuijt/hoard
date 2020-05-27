module Helpers
  module Authentication
    def log_in_as(user)
      OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new(
        {
          provider: "twitter",
          uid: user.uid || "123456789",
          info: {
            nickname: "asdf",
            name: "Asdf",
            image: "image_url"
          },
        }
      )
      get "/users/auth/twitter"
      follow_redirect!
    end
  end
end
