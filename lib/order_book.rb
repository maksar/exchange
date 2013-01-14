class OrderBook
  def initialize
    @orders = []
  end

  def place_order order
    @orders << order
  end

  def list_orders
    @orders
  end
end
