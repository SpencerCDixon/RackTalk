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

      if route = find_route(env)
        [200, { 'Content-Type' => 'text/html' }, [route[:body].call]]
      else
        not_found
      end
    end

    def find_route(env)
      path = env["PATH_INFO"]

      route = router.find do |route|
        route[:path] == path
      end

      route || false
    end

    def routes(&block)
      instance_eval(&block)
    end

    def get(path, &block)
      router << { path: path, body: block }
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

  class Router
    attr_reader :rules
    HTTP_VERBS = [:get, :post, :patch, :put, :delete]

    def initialize
      @rules = []
    end

    def get(path, options)
      @rules << { path: path }
    end
  end
end
