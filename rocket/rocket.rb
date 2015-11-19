require 'pry'
require 'erubis'
require 'rack'
require 'haml'

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

    def not_found
      [404, { 'Content-Type' => 'text/html' }, ["<h1>Page doesn't exist!</h1>"]]
    end

    def find_route(env)
      path = env["PATH_INFO"]

      current_route = router.find do |route|
        route[:path] == path
      end

      current_route || false
    end

    def routes(&block)
      instance_eval(&block)
    end

    def get(path, &block)
      router << { path: path, body: block }
    end

    def erb(view, locals = {})
      if layout = File.read("views/layout.html.erb")
        render_layout(layout) do
          render_erb_view(view, locals)
        end
      else
        render_erb_view(view, locals)
      end
    end

    def haml(view, locals = {})
      if layout = File.read("views/layout.html.erb")
        render_layout(layout) do
          render_haml_view(view, locals)
        end
      else
        render_haml_view(view, locals)
      end
    end

    def render_erb_view(view, locals)
      filename = File.join("views", "#{view}.html.erb")
      template = File.read filename
      Erubis::Eruby.new(template).evaluate(locals)
    end

    def render_haml_view(view, locals)
      filename = File.join("views", "#{view}.html.haml")
      template = File.read filename
      Haml::Engine.new(template).render(self, locals)
    end

    def render_layout(layout)
      Erubis::Eruby.new(layout).result(binding)
    end

    def get_binding
      return binding
    end
  end
end
