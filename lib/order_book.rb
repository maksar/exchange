require_relative 'observable'

class OrderBook
  include Observable

  attr_reader :orders

  def initialize
    @orders = []
  end

  def find id
    @orders.detect {|o| o.id == id }
  end

  def add order
    @orders << order
    order.id = next_sequence.tap { notify_add [order] }
    order
  end

  def delete order
    @orders.delete order
    notify_remove [order]
  end

  def change id
    order = find(id)
    notify_change [order] if order
  end

  private

  def next_sequence
    @next_sequence ||= 0
    @next_sequence += 1
  end
end