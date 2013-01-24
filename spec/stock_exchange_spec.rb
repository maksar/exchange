require_relative 'spec_helper'
require_relative '../stock_exchange'
require_relative '../lib/user'
require_relative '../lib/confirmation'
require_relative '../lib/order_book'
require_relative '../lib/confirmation_queue'

describe 'main flow' do
  describe 'normal flow' do
    let(:seller) { User.new Wallet.new(0.0), Portfolio.new([Stock.new('APPL', 100)]) }
    let(:buyer) { User.new Wallet.new(10000.0), Portfolio.new([]) }

    let(:order_book) { OrderBook.new }
    let(:queue) { ConfirmationQueue.new order_book }

    before {
      # TODO to a.shestakov Fix ugly nil
      queue.add Confirmation.new(buyer, nil, 49), order_book.add(SellOrder.new(seller, 'APPL', 100, 100.0))
      queue.add Confirmation.new(seller, nil, 3), order_book.add(BuyOrder.new(buyer, 'APPL', 100, 100.0))
      queue.add Confirmation.new(seller, nil, 0), order_book.add(Order.new(buyer, 'APPL', 100, 100.0))
    }

    it 'properly processes confirmations' do
      process_confirmations queue

      seller.wallet.funds.must_equal 5200.0
      seller.portfolio.stocks_count('APPL').must_equal 48

      buyer.wallet.funds.must_equal 4800.0
      buyer.portfolio.stocks_count('APPL').must_equal 52
    end
  end
end
