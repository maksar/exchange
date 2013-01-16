require_relative 'order'
require_relative 'confirmation'
require_relative 'seller'
require_relative 'buyer'

class UnknownOrderType < Exception ; end

class PartiesDeterminer < Struct.new :confirmation

  def resolve
    seller, buyer = case confirmation.order
      when SellOrder
        [confirmation.order.user, confirmation.user]
      when BuyOrder
        [confirmation.user, confirmation.order.user]
      else
        raise UnknownOrderType.new
    end
    [seller.extend(Seller), buyer.extend(Buyer)]
  end
end
