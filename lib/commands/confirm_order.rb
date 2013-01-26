require_relative '../order'

class ConfirmOrder
  def initialize order_book
    @order_book = order_book
  end

  def execute params
    order = @order_book.find params['id']
    # @order_book.add type(params).new 'user', params['stock'], params['count'], params['price']
  end

end
