require_relative '../lib/order_book'

describe OrderBook do
  let(:subject) { OrderBook.new }

  it 'is possible to place an order' do
    order = double 'order'
    subject.place_order order
    subject.list_orders.must_equal [order]
  end
end
