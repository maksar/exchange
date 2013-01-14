require_relative 'parties_determiner'

class TooManyStocksRequested < Exception ; end
class NotEnoughFunds < Exception ; end
class NotEnoughStocks < Exception ; end
class ImpossibleToSelfSell < Exception ; end

class OrderExecutor
  attr_reader :order, :seller, :buyer

  def initialize order
    @order = order
  end

  def confirm confirmation, parties_determiner = PartiesDeterminer.new(order)
    raise TooManyStocksRequested.new if confirmation.count > order.count

    @seller, @buyer = parties_determiner.resolve(confirmation)

    raise ImpossibleToSelfSell.new if buyer == seller
    raise NotEnoughFunds.new if buyer.funds < order.cost
    raise NotEnoughStocks.new if seller.stocks(order.stock) < confirmation.count

    seller.move_stocks(buyer, order.stock, confirmation.count, order.price)
  end
end
