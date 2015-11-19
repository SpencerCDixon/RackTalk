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

    def get(path, &response_body)
      router << { path: path, body: response_body }
    end

    def not_found
      [404, { 'Content-Type' => 'text/html' }, ['Page is not there']]
    end
  end
end
