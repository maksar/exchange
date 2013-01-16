require_relative 'lib/order_executor'

# CONFIRMATION_QUEUE = Queue.new

def start
  Thread.new do
    queue.pop do |confirmation|
      process_confirmation confirmation
    end
  end
end

def process_confirmation confirmation
  OrderExecutor.new(confirmation).execute
end

start if __FILE__ == $0
