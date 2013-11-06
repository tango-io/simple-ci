CONFIG = YAML.load_file("#{Rails.root}/config/github_credentials.yml")[Rails.env]

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, CONFIG['client_id'], CONFIG['client_secret'],scope: "user, public_repo"
end
