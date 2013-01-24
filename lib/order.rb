require_relative 'user'

class Order
  attr_accessor :id
  attr_reader :user, :stock, :price

  def initialize user, stock, count, price
    @user = user
    @stock = stock
    @count = count
    @price = price
  end

  def to_json(*a)
    {id: @id, user: @user, stock: @stock, count: @count, price: @price, type: self.class.name.downcase.gsub(/order/, '')}.to_json(*a)
  end
end

class SellOrder < Order
end

class BuyOrder < Order
end
