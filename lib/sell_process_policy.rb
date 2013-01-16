require_relative 'confirmation'

class TooManyStocksRequested < Exception ; end
class NotEnoughFunds < Exception ; end
class NotEnoughStocks < Exception ; end
class ImpossibleToSelfSell < Exception ; end

class SellProcessPolicy < Struct.new :seller, :buyer, :confirmation
  def check
    raise TooManyStocksRequested.new if confirmation.count > order.count
    raise ImpossibleToSelfSell.new if buyer == seller
    raise NotEnoughFunds.new unless buyer.enough_funds? confirmation.cost
    raise NotEnoughStocks.new unless seller.enough_stocks? order.stock, confirmation.count
  end

  private

  def order
    confirmation.order
  end
end
