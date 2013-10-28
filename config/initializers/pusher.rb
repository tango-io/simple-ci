#
# This app is going to use another websocket provider
# in the near future.
#
PUSHER = YAML.load_file("#{Rails.root}/config/pusher.yml")

Pusher.app_id = PUSHER['app_id']
Pusher.key = PUSHER['key']
Pusher.secret = PUSHER['secret']
