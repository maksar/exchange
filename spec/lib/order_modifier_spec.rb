require_relative '../spec_helper'
require_relative '../../lib/order_modifier'

describe OrderModifier do
  let(:order_book) { double 'order book' }
  subject { OrderModifier.new order_book }

  it 'removes specified stocks from order and deletes it' do
    order = OpenStruct.new count: 42

    mock(order_book).delete order
    subject.modify order, 42

    order.count.must_equal 0
  end

  it 'removes specified stocks from order and chnages it' do
    order = OpenStruct.new count: 42

    mock(order_book).change order
    subject.modify order, 41

    order.count.must_equal 1
  end
end
