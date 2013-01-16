require_relative '../spec_helper'
require_relative '../../lib/sell_process'

describe SellProcess do
  let(:seller) { double 'seller' }
  let(:buyer) { double 'buyer' }
  let(:confirmation) { OpenStruct.new :count => 2, :order => OpenStruct.new(:stock => 'APPL', :price => 3 ) }
  subject { SellProcess.new seller, buyer, confirmation }
  it 'should contain seller, buyer and confirmation fields' do
    subject.seller.must_equal seller
    subject.buyer.must_equal buyer
    subject.confirmation.must_equal confirmation
  end

  it 'does not move money or stocks if policies raised some error' do
    mock(sell_process_policy = double('sell process policy')).check do
      raise Exception.new
    end

    dont_allow(mover = double('mover')).move

    -> { subject.perform sell_process_policy, mover, mover }.must_raise Exception
  end

  it 'moves money from buyer to seller' do
    stub(sell_process_policy = double('sell process policy')).check

    mock(money_mover = double('money mover')).move 6

    subject.perform sell_process_policy, stub!.move.subject, money_mover
  end

  it 'moves stocks from seller to buyer' do
    stub(sell_process_policy = double('sell process policy')).check

    mock(stocks_mover = double('stocks mover')).move 'APPL', 2

    subject.perform sell_process_policy, stocks_mover, stub!.move.subject
  end
end
