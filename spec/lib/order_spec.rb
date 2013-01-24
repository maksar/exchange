require_relative '../spec_helper'
require_relative '../../lib/order'

describe Order do
  it 'should have user, stock, count and price specified' do
    order = Order.new('user', 'APPL', 10, 1)
    order.user.must_equal 'user'
    order.stock.must_equal 'APPL'
    order.count.must_equal 10
    order.price.must_equal 1
  end

  it 'should have assignable id' do
    order = Order.new
    order.id = 123
    order.id.must_equal 123
  end
end
