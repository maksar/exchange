require_relative '../spec_helper'
require_relative '../../lib/order_book'

describe OrderBook do
  let(:order) { OpenStruct.new }
  subject { OrderBook.new }

  it 'adds order' do
    id = subject.add order
    subject.find(order.id).must_equal order
  end

  it 'deletes order' do
    id = subject.add order

    subject.delete order
    subject.find(id).must_equal nil
  end

  # TODO to a.shestakov This test is basically useless. Think about how to re-implement change method.
  it 'chnages order' do
    id = subject.add order

    subject.change order
  end
end
