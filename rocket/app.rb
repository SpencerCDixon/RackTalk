require './rocket'

App = Rocket::Application.new

App.routes do
  get '/' do
    erb :slides
  end

  get '/slides' do
    haml :slides
  end
end

