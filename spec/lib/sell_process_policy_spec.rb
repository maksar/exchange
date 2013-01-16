require_relative '../spec_helper'
require_relative '../../lib/sell_process_policy'

describe SellProcessPolicy do
  let(:seller) { double 'seller' }
  let(:buyer) { double 'buyer' }

  let(:order) { OpenStruct.new :user => seller, :stock => 'A', :count => 10 }
  let(:confirmation) { OpenStruct.new :user => buyer, :order => order, :count => 10 }

  subject { SellProcessPolicy.new(seller, buyer, confirmation) }

  before {
    stub(confirmation).cost { 42 }

    stub(buyer).enough_funds? { true }
    stub(seller).enough_stocks? { true }

  }

  it 'should raise error if confirmation contains more stocks that exists' do
    stub(confirmation).count { 11 }
    -> { subject.check }.must_raise TooManyStocksRequested
  end

  it 'should raise error if there are not enough funds' do
    stub(buyer).enough_funds?(42) { false }
    -> { subject.check }.must_raise NotEnoughFunds
  end

  it 'should raise error if there are not enough stocks' do
    stub(seller).enough_stocks?('A', 10) { false }
    -> { subject.check }.must_raise NotEnoughStocks
  end

  it 'should not be possible to sell or buy to yourself' do
    subject.buyer = seller
    -> { subject.check }.must_raise ImpossibleToSelfSell
  end
end
