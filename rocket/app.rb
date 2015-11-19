require './rocket'

App = Rocket::Application.new

App.routes do
  get '/' do
    haml :slides
  end
end

