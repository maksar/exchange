require 'em-websocket'

require_relative 'lib/order_book'
require_relative 'lib/commands/command'
require_relative 'lib/change'

EventMachine.run {
  @order_book = OrderBook.new

  @order_book.add SellOrder.new('maksar', 'APPL', 42, 12)
  @order_book.add SellOrder.new('user', 'GOOG', 41, 322)
  @order_book.add BuyOrder.new('user', 'ITRA', 423, 32)

  @orders_channel = EM::Channel.new

  @order_book.subscribe_add ->(change) { @orders_channel.push Change.new(change).add }
  @order_book.subscribe_remove ->(change) { @orders_channel.push Change.new(change).remove }

  EventMachine::WebSocket.start(host: Socket.gethostname, port: 8080, debug: true) do |ws|
    ws.onopen {
      sid = @orders_channel.subscribe { |msg| ws.send msg }
      ws.onclose {
        @orders_channel.unsubscribe(sid)
      }

      ws.send Change.new(@order_book.orders).add

      ws.onmessage {|msg| Command.new(@order_book, msg).execute }
    }
  end
}