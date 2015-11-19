require 'pry'

# Namespace our application
module Rocket
  class Application
    def call(env)
      [200, { 'Content-Type' => 'text/plain' }, ['<h1>Hello from Rocket</h1>']]
    end
  end

  class Canadianize
    def initialize(app)
      @app = app
    end

    def call(env)
      binding.pry
      start = Time.now
      # Add an example to the headers
      env["rack.canadianized"] = "Added canada flavored response"

      # Add an example to the body of the response
      status, headers, content = @app.call(env)
      end_time = Time.now
      binding.pry

      # multiple variable assignemnt
      content[0] += ", eh?"

      [status, headers, content]
    end
  end
end
