require './rocket'

App = Rocket::Application.new

App.routes do
  get '/' do
    "hello"
  end

  get '/rocket' do
    erb :example, { title: 'rocket title' }
  end
end

