require 'json/ext'
require_relative 'add_order'
require_relative 'cancel_order'
require_relative 'confirm_order'

class Command
  def initialize order_book, confirmation_queue, message
    @order_book = order_book
    @confirmation_queue = confirmation_queue
    @message = message
  end

  def execute
    case action
      when 'confirmOrder'
        ConfirmOrder.new(@order_book, @confirmation_queue)
      when 'createOrder'
        AddOrder.new(@order_book)
      when 'cancel'
        CancelOrder.new(@order_book)
    end.execute params
  rescue Exception => e
    puts e.inspect
    puts e.backtrace.inspect
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