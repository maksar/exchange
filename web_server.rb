require 'sprockets'
require 'goliath'

require_relative 'lib/goliath/rack/sprockets'

class StockExchange < Goliath::API
  use Rack::Static,
      root:  Goliath::Application.app_path("public"),
      urls:  ['/index.html', '/favicon.ico'],
      index: 'index.html'

  use Goliath::Rack::Sprockets
end