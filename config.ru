run lambda { |env| [200, {'Content-Type'=>'text/plain'}, StringIO.new("Hello World!\n")] }
require './RollToDodge'
require './creds'
require './privateData'
require './functions'
run Sinatra::Application
