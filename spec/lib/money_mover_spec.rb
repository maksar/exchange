require_relative '../spec_helper'
require_relative '../../lib/money_mover'

describe MoneyMover do
  let(:seller) { double 'seller' }
  let(:buyer) { double 'buyer' }
  subject { MoneyMover.new seller, buyer }

  it 'moves money from buyer to seller' do
    mock(buyer).remove_funds 42
    mock(seller).add_funds 42
    subject.move 42
  end
end
