require_relative 'stock'

class Portfolio < Struct.new :stocks
  def change_stocks name, count
    stock = find_stock(name)
    stocks << (stock = Stock.new(name, 0)) unless stock

    stock.count += count
  end

  def stocks_count name
    find_stock(name).count
  end

  private

  def find_stock name
    stocks.detect {|s| s.name == name }
  end
end
