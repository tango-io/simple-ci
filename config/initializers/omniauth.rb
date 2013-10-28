Rails.application.config.middleware.use OmniAuth::Builder do
  config = YAML.load_file("#{Rails.root}/config/github_credentials.yml")[Rails.env]
  provider :github, config['client_id'], config['client_secret']
end
