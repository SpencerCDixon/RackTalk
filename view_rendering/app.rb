require './rocket'

App = Rocket::Application.new

App.routes do
  get '/' do
    "hello from rocket"
  end
end

