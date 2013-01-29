class OrderModifier < Struct.new :order_book
  def modify order, count
    order.count -= count

    return order_book.delete order if order.count == 0

    order_book.change order.id
  end
end