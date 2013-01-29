require_relative 'stock'

class Portfolio < Struct.new :stocks
  def change_stocks name, count
    stock = find_stock(name)
    stocks << (stock = Stock.new(name, 0)) unless stock

    stock.count += count
  end

  def stocks_count name
    stock = find_stock(name)
    stock ? stock.count : 0
  end

  private

  def find_stock name
    stocks.detect {|s| s.name == name }
  end
end
