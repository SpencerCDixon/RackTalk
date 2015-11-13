require 'rack'

app = Proc.new do |env|
  ['200', {'Content-Type' => 'text/html'}, ['Hello world from Rack!']]
end

# app is an object that responds to #call
# #call returns 3 things: status code, HTTP headers, and response body
# both the headers and response body respond to #each

Rack::Handler::WEBrick.run app
