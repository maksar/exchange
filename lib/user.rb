require_relative 'wallet'
require_relative 'portfolio'

class User
  attr_accessor :name, :wallet, :portfolio

  def initialize name, wallet, portfolio
    @name = name
    @wallet = wallet
    @portfolio = portfolio
  end

  def balance
    wallet.funds
  end

  def stocks
    portfolio.stocks
  end
end
