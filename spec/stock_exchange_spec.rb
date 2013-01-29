require_relative 'spec_helper'
require_relative '../lib/user'
require_relative '../lib/confirmation'
require_relative '../lib/order_book'
require_relative '../lib/order_executor'

describe 'main flow' do
  describe 'normal flow' do
    let(:seller) { User.new Wallet.new(0.0), Portfolio.new([Stock.new('APPL', 100)]) }
    let(:buyer) { User.new Wallet.new(10000.0), Portfolio.new([]) }

    let(:order_book) { OrderBook.new }
    before {
      OrderExecutor.new(order_book, Confirmation.new(buyer, order_book.add(SellOrder.new(seller, 'APPL', 100, 100.0)), 49)).execute
      OrderExecutor.new(order_book, Confirmation.new(seller, order_book.add(BuyOrder.new(buyer, 'APPL', 100, 100.0)), 3)).execute
    }

    it 'properly processes confirmations' do
      seller.wallet.funds.must_equal 5200.0
      seller.portfolio.stocks_count('APPL').must_equal 48

      buyer.wallet.funds.must_equal 4800.0
      buyer.portfolio.stocks_count('APPL').must_equal 52

      order_book.find(1).count.must_equal 51
      order_book.find(2).count.must_equal 97
    end
  end
end
