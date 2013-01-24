require_relative '../spec_helper'
require_relative '../../lib/confirmation_queue'

describe ConfirmationQueue do
  let(:order_book) { OrderBook.new }
  subject { ConfirmationQueue.new order_book }
  let(:order) { OpenStruct.new }
  let(:confirmation) { OpenStruct.new :order => nil }

  before { order_book.add order}

  it 'should add confirmation to the existing order' do
    subject.add confirmation, order.id
    subject.size.must_equal 1
  end

  it 'should not add confirmation to the missing order' do
    subject.add confirmation, 0
    subject.size.must_equal 0
  end

  it 'allows to pop from queue' do
    subject.add confirmation, order.id
    subject.pop.must_equal confirmation
  end
end