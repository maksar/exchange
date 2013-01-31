require 'em-websocket'

require_relative 'lib/order_executor'
require_relative 'lib/order_book'
require_relative 'lib/commands/command'
require_relative 'lib/change'

$maksar = User.new 'maksar', Wallet.new(0.0), Portfolio.new([Stock.new('ITRA', 100), Stock.new('APPL', 42)])
$user = User.new 'user', Wallet.new(10000.0), Portfolio.new([])

@order_book = OrderBook.new

@order_book.add BuyOrder.new($user, 'ITRA', 423, 32)
@order_book.add SellOrder.new($maksar, 'APPL', 42, 12)
@order_book.add SellOrder.new($user, 'GOOG', 41, 322)

@orders_channel = EM::Channel.new

# TODO to a.shestakov Replace with only one handler
@order_book.subscribe_add ->(change) { @orders_channel.push Change.new(change, $maksar).add }
@order_book.subscribe_remove ->(change) { @orders_channel.push Change.new(change, $maksar).remove }
@order_book.subscribe_change ->(change) { @orders_channel.push Change.new(change, $maksar).change }

@confirmation_queue = EM::Queue.new

confirm = ->(confirmation) {
  OrderExecutor.new(@order_book, confirmation).execute
  EM.next_tick { @confirmation_queue.pop &confirm }
}
@confirmation_queue.pop &confirm

EM.run {
  EventMachine::WebSocket.start(host: '0.0.0.0', port: 8080, debug: true) do |ws|
    ws.onopen {
      sid = @orders_channel.subscribe { |msg| EM.next_tick { ws.send msg } }
      ws.onclose {
        @orders_channel.unsubscribe(sid)
      }

      # Sending all orders on first connection
      ws.send Change.new(@order_book.orders, $maksar).add

      ws.onmessage { |msg|
        EM.next_tick { Command.new(@order_book, @confirmation_queue, msg).execute }
      }
    }
  end
}

