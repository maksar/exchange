require 'em-websocket'
require 'json/ext'

require_relative 'lib/order_book'
require_relative 'lib/commands/add_order'
require_relative 'lib/commands/cancel_order'

EventMachine.run {
  @order_book = OrderBook.new
  @order_book.add SellOrder.new('maksar', 'APPL', 42, 12)
  @order_book.add SellOrder.new('user', 'GOOG', 41, 322)
  @order_book.add BuyOrder.new('user', 'ITRA', 423, 32)

  @orders_channel = EM::Channel.new

  @order_book.subscribe_add { |change| @orders_channel.push({add: change, remove: []}.to_json) }
  @order_book.subscribe_remove { |change| @orders_channel.push({remove: change, add: []}.to_json) }

  EventMachine::WebSocket.start(:host => "0.0.0.0", :port => 8080, :debug => true) do |ws|

    ws.onopen {
      ws.send({add: @order_book.orders, remove: []}.to_json)
      sid = @orders_channel.subscribe { |msg| ws.send msg }

      ws.onmessage { |msg|
      begin
        command = JSON.parse msg

        case command['action']
          when 'createOrder'
            AddOrder.new(@order_book).execute command['params']
          when 'cancel'
            CancelOrder.new(@order_book).execute command['params']
        end
      rescue Exception => e
        puts e.inspect
      end
      }

      ws.onclose {
        @orders_channel.unsubscribe(sid)
      }
    }

  end

  puts "Server started"
}