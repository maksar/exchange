module Buyer
  def enough_funds? amount
    wallet.funds >= amount
  end

  def remove_funds amount
    wallet.change_funds(-amount)
  end

  def add_stocks name, count
    portfolio.change_stocks(name, count)
  end
end
