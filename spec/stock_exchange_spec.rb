require_relative 'spec_helper'
require_relative '../stock_exchange'
require_relative '../lib/user'
require_relative '../lib/confirmation'

describe 'main flow' do
  describe 'normal flow' do
    let(:seller) { User.new Wallet.new(0.0), Portfolio.new([Stock.new('APPL', 100)]) }
    let(:buyer) { User.new Wallet.new(10000.0), Portfolio.new([]) }

    before {
      CONFIRMATION_QUEUE << Confirmation.new(buyer, SellOrder.new(seller, 'APPL', 100, 100.0), 49)
      CONFIRMATION_QUEUE << Confirmation.new(seller, BuyOrder.new(buyer, 'APPL', 100, 100.0), 3)
      CONFIRMATION_QUEUE << Confirmation.new(seller, Order.new(buyer, 'APPL', 100, 100.0), 0)
    }

    it 'properly processes confirmations' do
      process_confirmations

      seller.wallet.funds.must_equal 5200.0
      seller.portfolio.stocks_count('APPL').must_equal 48

      buyer.wallet.funds.must_equal 4800.0
      buyer.portfolio.stocks_count('APPL').must_equal 52
    end
  end
end
