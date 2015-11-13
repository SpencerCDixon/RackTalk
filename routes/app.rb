require './rocket'

App = Rocket::Application.new

App.routes do
  get '/' do
    "hello"
  end

  get '/rocket' do
    "rocket is sweet!"
  end
end

