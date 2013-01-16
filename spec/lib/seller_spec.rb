require_relative '../../lib/seller'

describe Seller do
  subject { Object.new.extend Seller }
  describe 'portfolio operations' do
    let(:portfolio) { double 'portfolio' }
    before { stub(subject).portfolio { portfolio } }

    it 'checks portfolio is enough stocks' do
      stub(portfolio).stocks_count('A') { 1 }
      subject.enough_stocks?('A', 2).must_equal false
      subject.enough_stocks?('A', 1).must_equal true
    end

    it 'removes stocks from portfolio' do
      mock(portfolio).change_stocks 'A', -24
      subject.remove_stocks 'A', 24
    end
  end

  describe 'wallet operations' do
    let(:wallet) { double 'wallet' }
    before { stub(subject).wallet { wallet } }
    it 'adds funds to wallet' do
      mock(wallet).change_funds 42
      subject.add_funds 42
    end
  end
end
