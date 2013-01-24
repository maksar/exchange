require_relative '../order'

class OrderNotFound < Exception ; end
class CannotCancelForeignOrder < Exception ; end

class CancelOrder
  def initialize order_book
    @order_book = order_book
  end

  def execute params
    raise OrderNotFound.new unless order = @order_book.find(params['id'])
    raise CannotCancelForeignOrder.new unless order.user == params['user']

    @order_book.delete order
  end
end
