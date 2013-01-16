require_relative '../spec_helper'
require_relative '../../lib/stocks_mover'

describe StocksMover do
  let(:seller) { double 'seller' }
  let(:buyer) { double 'buyer' }
  subject { StocksMover.new seller, buyer }

  it 'moves stocks from seller to buyer' do
    mock(seller).remove_stocks 'APPL', 42
    mock(buyer).add_stocks 'APPL', 42
    subject.move 'APPL', 42
  end
end
