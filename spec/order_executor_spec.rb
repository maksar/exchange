require_relative '../lib/order_executor'
require_relative '../lib/order'

describe OrderExecutor do
  let(:seller) { double 'seller' }
  let(:buyer) { double 'buyer' }

  let(:order) { SellOrder.new('A', 10, 1) }
  let(:confirmation) { double 'confirmation' }

  before {
    stub(seller).stocks('A') { 10 }
    stub(buyer).funds { 10 }
    stub(confirmation).count { 10 }

    stub(confirmation).user { buyer }
    stub(order).user { seller }

    stub(seller).move_stocks
  }

  it 'should raise error if confirmation contains more stocks that exists' do
    stub(confirmation).count { 11 }

    -> { OrderExecutor.new(order).confirm confirmation }.must_raise TooManyStocksRequested
  end

  it 'should raise error if there are not enough funds' do
    stub(buyer).funds { 0 }
    -> { OrderExecutor.new(order).confirm confirmation }.must_raise NotEnoughFunds
  end

  it 'should raise error if there are not enough stocks' do
    stub(seller).stocks('A') { 0 }
    -> { OrderExecutor.new(order).confirm confirmation }.must_raise NotEnoughStocks
  end

  it 'should not be possible to sell or buy to yourself' do
    stub(confirmation).user { seller }
    -> { OrderExecutor.new(order).confirm confirmation }.must_raise ImpossibleToSelfSell
  end

  it 'moves stocks from seller to buyer' do
    mock(seller).move_stocks(buyer, 'A', 10, 1)
    OrderExecutor.new(order).confirm confirmation
  end

  describe 'recognizes buyer and seller properly' do
    it 'in case of buy order' do
      order = BuyOrder.new('A', 10, 1)
      stub(order).user { buyer }
      stub(confirmation).user { seller }

      executor = OrderExecutor.new(order)
      executor.confirm confirmation

      executor.buyer.must_equal order.user
      executor.seller.must_equal confirmation.user
    end

    it 'in case of sell order' do
      order = SellOrder.new('A', 10, 1)
      stub(order).user { seller }
      stub(confirmation).user { buyer }

      executor = OrderExecutor.new(order)
      executor.confirm confirmation

      executor.buyer.must_equal confirmation.user
      executor.seller.must_equal order.user
    end
  end
end
