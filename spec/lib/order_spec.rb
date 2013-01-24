require_relative '../spec_helper'
require_relative '../../lib/order'

describe Order do
  subject { SellOrder.new 'user', 'APPL', 10, 1 }

  it 'should have user, stock, count and price specified' do
    subject.user.must_equal 'user'
    subject.stock.must_equal 'APPL'
    subject.count.must_equal 10
    subject.price.must_equal 1
  end

  it 'should have assignable id' do
    subject.id = 123
    subject.id.must_equal 123
  end

  it 'should convert itself to json' do
    subject.to_json(nil).must_equal "{\"id\":null,\"user\":\"user\",\"stock\":\"APPL\",\"count\":10,\"price\":1,\"type\":\"sell\"}"
  end
end
