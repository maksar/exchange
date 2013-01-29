require_relative '../confirmation'

class ConfirmOrder
  def initialize order_book, confirmation_queue
    @order_book = order_book
    @confirmation_queue = confirmation_queue
  end

  def execute params
    order = @order_book.find params['id']
    count = params['count']

    # TODO to a.shestakov redundant order param in confirmation
    @confirmation_queue << Confirmation.new($maksar, order, count) if order
  end
end
