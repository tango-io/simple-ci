Rails.application.config.middleware.use OmniAuth::Builder do
  CONFIG = YAML.load_file("#{Rails.root}/config/github_credentials.yml")[Rails.env]
  provider :github, CONFIG['client_id'], CONFIG['client_secret']
end
