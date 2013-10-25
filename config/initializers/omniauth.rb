Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, '908ded3d57e242e4a2d9', '1580a671b62467fd6181edfc1068b5878100ab4d'
end
