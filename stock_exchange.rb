require_relative 'lib/order_executor'

CONFIRMATION_QUEUE = Queue.new

def process_confirmations queue = CONFIRMATION_QUEUE
  while !queue.empty? do
    process_confirmation queue.pop(true)
  end
end

def process_confirmation confirmation
  OrderExecutor.new(confirmation).execute
rescue Exception => e
  # Do nothing for now
end

start if __FILE__ == $0
