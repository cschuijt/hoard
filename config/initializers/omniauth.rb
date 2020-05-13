Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
  provider :twitter,
            Rails.application.credentials.twitter[:key],
            Rails.application.credentials.twitter[:secret],
            authorize_params: { force_login: 'true' }
end
