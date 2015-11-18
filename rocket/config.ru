require './app'

use Rack::Static,
  :urls => ["/images", "/js", "/css"],
  :root => 'public'

run App
