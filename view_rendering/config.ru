require './app'
require 'rack'

use Rack::Static,
  :urls => ["/images", "/js", "/css"],
  :root => 'public'

run App
