require 'json/ext'
require_relative 'user'

class Order
  attr_accessor :id
  attr_reader :user, :stock, :count, :price

  def initialize user, stock, count, price
    @user = user
    @stock = stock
    @count = count
    @price = price
  end

  def to_json _
    {
      id: @id,
      user: @user,
      stock: @stock,
      count: @count,
      price: @price,
      type: json_type
    }.to_json
  end

  private

  def json_type
    self.class.name.downcase.gsub(/order/, '')
  end

end

class SellOrder < Order
end

class BuyOrder < Order
end
