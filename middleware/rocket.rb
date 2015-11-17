require 'pry'

module Rocket
  class Application
    attr_reader :router
    def initialize
      @router = []
    end

    def call(env)
      if env['PATH_INFO'] == '/favicon.ico'
        return not_found
      end

      if route = router.find { |r| r[:path] == env['PATH_INFO'] }
        [200, { 'Content-Type' => 'text/html' }, [route[:body].call]]
      end
    end

    def routes(&block)
      instance_eval(&block)
    end

    def get(path, &block)
      router << { path: path, body: block }
    end

    def not_found
      [404, { 'Content-Type' => 'text/html' }, []]
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
      # content[0] += ", eh?"
      # [status, headers, content]
    # end
  # end
end
