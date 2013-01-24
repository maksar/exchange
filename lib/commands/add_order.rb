require_relative '../order'

class BadParameter < Exception ; end

class AddOrder
  def initialize order_book
    @order_book = order_book
  end

  def execute params
    @order_book.add type(params).new 'user', params['stock'], params['count'], params['price']
  end

  private

  def type params
    case params['type']
      when 'sell'
        SellOrder
      when 'buy'
        BuyOrder
      else
        raise BadParameter.new('type')
    end
  end
end
