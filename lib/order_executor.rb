class TooManyStocksRequested < Exception ; end
class NotEnoughFunds < Exception ; end
class NotEnoughStocks < Exception ; end
class ImpossibleToSelfSell < Exception ; end

class OrderExecutor
  attr_reader :order, :seller, :buyer

  def initialize order
    @order = order
  end

  def confirm confirmation
    raise TooManyStocksRequested.new if confirmation.count > order.count
    determine_parties confirmation

    raise ImpossibleToSelfSell.new if buyer == seller
    raise NotEnoughFunds.new if buyer.funds < order.cost
    raise NotEnoughStocks.new if seller.stocks(order.stock) < confirmation.count

    seller.move_stocks(buyer, order.stock, confirmation.count, order.price)
  end

  private

  def determine_parties confirmation
    @seller, @buyer = case @order
      when SellOrder
        [order.user, confirmation.user]
      when BuyOrder
        [confirmation.user, order.user]
    end
  end
end
