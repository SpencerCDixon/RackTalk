require 'pry'

# Namespace our application
module Rocket
  class Application
    def call(env)
      [200, { 'Content-Type' => 'text/html' }, ['Hello from Rocket']]
    end
  end

  # class Canadianize
    # def initialize(app)
      # @app = app
    # end

    # def call(env)
      # # Add an example to the headers
      # env["rack.canadianized"] = "Added canada flavored response"

      # # Add an example to the body of the response
      # status, headers, content = @app.call(env)

      # # multiple variable assignemnt
      # content[0] += ", eh?"

      # [status, headers, content]
    # end
  # end
end
