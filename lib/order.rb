require_relative 'user'

class Order < Struct.new :user, :stock, :count, :price
end

class SellOrder < Order
end

class BuyOrder < Order
end
