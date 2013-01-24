require_relative '../spec_helper'
require_relative '../../lib/parties_determiner'
require_relative '../../lib/order'

describe PartiesDeterminer do
  let(:user) { double 'user' }
  let(:confirmation) { OpenStruct.new :user => user }

  it 'determines parties in buy order' do
    confirmation.order = BuyOrder.new((buyer = double('buyer')), 'A', 10, 1)

    parties = PartiesDeterminer.new(confirmation).resolve
    parties.must_equal [user, buyer]
    parties.first.must_be_kind_of Seller
    parties.last.must_be_kind_of Buyer
  end

  it 'determines parties in sell order' do
    confirmation.order = SellOrder.new((seller = double('seller')), 'A', 10, 1)

    parties = PartiesDeterminer.new(confirmation).resolve
    parties.must_equal [seller, user]
    parties.first.must_be_kind_of Seller
    parties.last.must_be_kind_of Buyer
  end

  it 'reports about unknown order type' do
    confirmation.order = Order.new nil, nil, nil, nil
    -> { PartiesDeterminer.new(confirmation).resolve }.must_raise UnknownOrderType
  end
end
