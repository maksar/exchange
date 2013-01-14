require_relative '../lib/order'

describe Order do
  it 'should have stock, count and price specified' do
    order = Order.new('APPL', 10, 1)
    order.stock.must_equal 'APPL'
    order.count.must_equal 10
    order.price.must_equal 1
  end

  it 'should be executable' do
    order_confirmation = double 'order_confirmation'

    order_executor = double 'order executor'
    mock(order_executor).confirm(order_confirmation)

    Order.new('APPL', 10, 1).execute(order_confirmation, order_executor)
  end
end
