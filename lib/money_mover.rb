class MoneyMover < Struct.new :seller, :buyer
  def move cost
    seller.add_funds cost
    buyer.remove_funds cost
  end
end
