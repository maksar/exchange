require_relative '../spec_helper'
require_relative '../../lib/confirmation'

describe Confirmation do
  it 'should have user, order and count fields' do
    confirmation = Confirmation.new('user', 'order', 10)
    confirmation.user.must_equal 'user'
    confirmation.order.must_equal 'order'
    confirmation.count.must_equal 10
  end

  it 'should return cost' do
    order = OpenStruct.new :price => 10
    Confirmation.new('user', order, 2).cost.must_equal 20
  end
end
