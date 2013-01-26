require 'json/ext'
require_relative 'add_order'
require_relative 'cancel_order'

class Command
  def initialize order_book, message
    @order_book = order_book
    @message = message
  end

  def execute
    case action
      when 'buy'
      when 'sell'
        ConfirmOrder.new(@order_book).execute params
      when 'createOrder'
        AddOrder.new(@order_book).execute params
      when 'cancel'
        CancelOrder.new(@order_book).execute params
    end
  end

  private

  def action
    command['action']
  end

  def params
    command['params']
  end

  def command
    JSON.parse @message
  end
end