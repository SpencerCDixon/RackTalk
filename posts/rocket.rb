require 'pry'
require 'erubis'
require 'rack'

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

      request_method = env['REQUEST_METHOD'].downcase.to_sym

      if route = find_route(env, request_method)
        [200, { 'Content-Type' => 'text/html' }, [route[:body].call]]
      else
        not_found
      end
    end

    def find_route(env, method_type)
      path = env["PATH_INFO"]

      route = router.find do |route|
        route[:path] == path && route[:method] == method_type
      end

      route || false
    end

    def routes(&block)
      instance_eval(&block)
    end

    def get(path, &block)
      router << { path: path, body: block, method: :get }
    end

    def post(path, &block)
      router << { path: path, body: block, method: :post }
    end

    def erb(view, locals = {})
      filename = File.join("views", "#{view}.html.erb")
      template = File.read filename
      eruby = Erubis::Eruby.new(template)
      eruby.result(locals)
    end

    def not_found
      [404, { 'Content-Type' => 'text/html' }, []]
    end
  end
end
