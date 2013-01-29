class OrderModifier < Struct.new :order_book
  def modify order, count
    order.count -= count

    if order.count == 0
      order_book.delete order
    else
      order_book.change order
    end
  end
end
