require 'goliath'
require 'http_router'

require_relative 'lib/commands/list_orders'
require_relative 'lib/commands/add_order'

require_relative 'lib/order_book'

class StockExchange < Goliath::API
  use Goliath::Rack::Formatters::JSON
  use Goliath::Rack::Render, 'json'

  use Goliath::Rack::Params

  def initialize
    @order_book = OrderBook.new
    
    @router = HttpRouter.new
    register_routes
  end

  def response env
    @router.call(env)
  end

  def register_routes
    @router.get('/orders').to ListOrders.new(@order_book).response
    @router.post('/orders').to AddOrder.new(@order_book).response
  end
end
