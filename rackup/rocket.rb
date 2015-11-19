require 'pry'

class Rocket
  def call(env)
    # binding.pry
    ['200', {'Content-Type' => 'text/html'}, ['Hello from rocket!']]
  end
end
