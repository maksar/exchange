require_relative '../spec_helper'
require_relative '../../lib/buyer'

describe Buyer do
  subject { Object.new.extend Buyer }
  describe 'wallet operations' do
    let(:wallet) { double 'wallet' }
    before { stub(subject).wallet { wallet } }

    it 'checks whether is enough funds' do
      stub(wallet).funds { 1 }
      subject.enough_funds?(2).must_equal false
      subject.enough_funds?(1).must_equal true
    end

    it 'removes funds from wallet' do
      mock(wallet).change_funds(-42)
      subject.remove_funds 42
    end
  end

  describe 'portfolio operations' do
    let(:portfolio) { double 'portfolio' }
    before { stub(subject).portfolio { portfolio } }
    it 'adds stocks to portfolio' do
      mock(portfolio).change_stocks 'A', 24
      subject.add_stocks 'A', 24
    end
  end
end
