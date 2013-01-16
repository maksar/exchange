require_relative 'user'
require_relative 'order'

class Confirmation < Struct.new :user, :order, :count
  def cost
    order.price * count
  end
end
