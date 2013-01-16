class Wallet < Struct.new :funds
  def change_funds amount
    self.funds += amount
  end
end
