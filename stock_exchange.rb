require_relative 'lib/order_executor'

def process_confirmations queue
  while queue.size > 0 do
    process_confirmation queue.pop
  end
end

def process_confirmation confirmation
  OrderExecutor.new(confirmation).execute
rescue Exception => e
  # Do nothing for now
end

start if __FILE__ == $0
