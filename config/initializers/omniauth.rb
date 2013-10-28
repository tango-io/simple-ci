Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, Rails.env['client_id'], Rails.env['client_secret']
end
