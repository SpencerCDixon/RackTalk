class Rocket
  def call(env)
    ['200', {'Content-Type' => 'text/html'}, ['Hello from rocket!']]
  end
end
