require_relative '../spec_helper'
require_relative '../../lib/order_book'

describe OrderBook do
  let(:order) { OpenStruct.new }
  subject { OrderBook.new }

  it 'deletes order' do
    id = subject.add order
    subject.find(order.id).must_equal order

    subject.delete order
    subject.find(id).must_equal nil
  end
end
