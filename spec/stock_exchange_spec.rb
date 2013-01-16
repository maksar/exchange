require_relative 'spec_helper'
require_relative '../stock_exchange'
require_relative '../lib/user'
require_relative '../lib/confirmation'

describe 'main flow' do
  describe 'normal flow' do
    let(:seller) { User.new Wallet.new(0.0), Portfolio.new([Stock.new('APPL', 100)]) }
    let(:buyer) { User.new Wallet.new(10000.0), Portfolio.new([]) }

    let(:order) { SellOrder.new(seller, 'APPL', 100, 100.0) }
    let(:confirmation) { Confirmation.new(buyer, order, 50) }

    it 'properly processes confirmation' do
      process_confirmation confirmation

      seller.wallet.funds.must_equal 5000.0
      seller.portfolio.stocks_count('APPL').must_equal 50

      buyer.wallet.funds.must_equal 5000.0
      buyer.portfolio.stocks_count('APPL').must_equal 50
    end
  end

  describe 'edge case' do
    let(:seller) { User.new Wallet.new(0.0), Portfolio.new([Stock.new('APPL', 100)]) }
    let(:buyer) { User.new Wallet.new(10000.0), Portfolio.new([]) }

    let(:order) { SellOrder.new(seller, 'APPL', 100, 100.0) }
    let(:confirmation) { Confirmation.new(buyer, order, 100) }

    it 'properly processes confirmation' do
      process_confirmation confirmation

      seller.wallet.funds.must_equal 10000.0
      seller.portfolio.stocks_count('APPL').must_equal 0

      buyer.wallet.funds.must_equal 0.0
      buyer.portfolio.stocks_count('APPL').must_equal 100
    end
  end
end
