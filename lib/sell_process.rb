require_relative 'sell_process_policy'
require_relative 'confirmation'
require_relative 'money_mover'
require_relative 'stocks_mover'

class SellProcess < Struct.new :seller, :buyer, :confirmation
  def perform sell_process_policy = SellProcessPolicy.new(seller, buyer, confirmation), stocks_mover = StocksMover.new(seller, buyer), money_mover = MoneyMover.new(seller, buyer)
    sell_process_policy.check
    stocks_mover.move confirmation.order.stock, confirmation.count
    money_mover.move confirmation.count * confirmation.order.price
  end
end

