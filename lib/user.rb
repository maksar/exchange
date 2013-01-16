require_relative 'wallet'
require_relative 'portfolio'

class User < Struct.new :wallet, :portfolio

end
