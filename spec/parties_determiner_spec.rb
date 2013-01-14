require_relative '../lib/parties_determiner'
require_relative '../lib/order'

describe PartiesDeterminer do
  let(:user) { double 'user' }
  let(:confirmation) { double 'confirmation' }
  before { stub(confirmation).user { user } }

  it 'in case of buy order' do
    order = BuyOrder.new('A', 10, 1)

    buyer = double 'buyer'
    stub(order).user { buyer }
    PartiesDeterminer.new(order).resolve(confirmation).must_equal [user, buyer]
  end

  it 'in case of sell order' do
    order = SellOrder.new('A', 10, 1)

    seller = double 'seller'
    stub(order).user { seller }
    PartiesDeterminer.new(order).resolve(confirmation).must_equal [seller, user]
  end

end
