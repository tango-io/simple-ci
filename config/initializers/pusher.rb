#
# This app is going to use another websocket provider
# in the near future.
#
key = YAML.load_file("#{Rails.root}/config/github_credentials.yml")[Rails.env]

Pusher.app_id = keys['app_id']
Pusher.key = keys['key']
Pusher.secret = keys['secret']
