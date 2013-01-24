require_relative '../spec_helper'
require_relative '../../lib/order_book'

describe OrderBook do
  let(:order) { OpenStruct.new }
  subject { OrderBook.new }

  it 'must assign id to the order' do
    id = subject.add order
    subject.orders.first.id.must_be :>, 0
    subject.orders.first.id.must_equal id
  end

  it 'finds order by id' do
    subject.add order
    subject.find(order.id).must_equal order
  end
end
