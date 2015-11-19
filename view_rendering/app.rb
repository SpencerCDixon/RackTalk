require './rocket'

App = Rocket::Application.new

App.routes do
  get '/' do
    "hello from rocket"
  end

  get '/erb_view' do
    erb :home, { title: 'Home page' }
  end
end

