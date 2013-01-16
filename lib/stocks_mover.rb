class StocksMover < Struct.new :seller, :buyer
  def move stock, count
    seller.remove_stocks stock, count
    buyer.add_stocks stock, count
  end
end
