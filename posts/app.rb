require './rocket'

App = Rocket::Application.new

App.routes do
  get '/' do
    "hello"
  end

  get '/rocket' do
    erb :example, { title: 'GET request' }
  end

  post '/rocket' do
    erb :example, { title: 'POST request' }
  end
end

