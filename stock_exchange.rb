require_relative 'lib/order_executor'

CONFIRMATION_QUEUE = Queue.new

def process_confirmations queue = CONFIRMATION_QUEUE
  while !queue.empty? do
    OrderExecutor.new(queue.pop(true)).execute
  end
end

start if __FILE__ == $0
