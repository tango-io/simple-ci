require 'faye'

websocket = Faye::RackAdapter.new(:mount => '/faye', :timeout => 25)

run websocket
