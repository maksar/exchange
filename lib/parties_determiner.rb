class PartiesDeterminer < Struct.new :order

  def resolve confirmation
    case order
      when SellOrder
        [order.user, confirmation.user]
      when BuyOrder
        [confirmation.user, order.user]
    end
  end
end
