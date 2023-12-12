# This file is used by Rack-based servers to start the application.

require_relative 'config/environment'
require 'rack/cors'

use Rack::Cors do
  allow do
    origins 'localhost:3001', 'localhost:3002', '127.0.0.1:3002'
    resource '*', headers: :any, methods: %i[get post delete put patch options], credentials: true
  end
end

run Rails.application
Rails.application.load_server
