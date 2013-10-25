Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, '61d06f186a48d777435b', '3930add738759d3f3c677a69be9c6d82266b552a'
end
