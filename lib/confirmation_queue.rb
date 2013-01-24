require_relative 'order_book'

class ConfirmationQueue
  def initialize order_book = OrderBook.new
    @order_book = order_book
    @queue = Queue.new
  end

  def add confirmation, order_id
    @queue << confirmation if confirmation.order = @order_book.find(order_id)
  end

  def pop
    @queue.pop(true)
  end

  def size
    @queue.size
  end
end