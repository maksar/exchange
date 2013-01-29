require_relative 'parties_determiner'
require_relative 'sell_process'
require_relative 'confirmation'

class OrderExecutor < Struct.new :order_book, :confirmation
  def execute parties_determiner = PartiesDeterminer.new(confirmation)
    SellProcess.new(order_book, *parties_determiner.resolve, confirmation).perform
  end
end
