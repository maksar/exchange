module Seller
  def enough_stocks? name, count
    portfolio.stocks_count(name) >= count
  end

  def add_funds amount
    wallet.change_funds amount
  end

  def remove_stocks name, count
    portfolio.change_stocks name, -count
  end
end
