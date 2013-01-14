require_relative 'order_executor'

class Order < Struct.new :stock, :count, :price

  def execute order_confirmation, order_executor = OrderExecutor.new(self)
    order_executor.confirm order_confirmation
  end

  def cost
    count * price
  end

# TODO to a.shestakov Remove
  def user
  end
end

class SellOrder < Order
end

class BuyOrder < Order
end
