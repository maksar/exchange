require_relative '../spec_helper'
require_relative '../../lib/order_executor'

describe OrderExecutor do
  let(:seller) { double 'seller' }
  let(:buyer) { double 'buyer' }
  let(:confirmation) { double 'confirmation' }
  let(:parties_determiner) { stub!.resolve { [seller, buyer] }.subject }

  it 'uses parties determiner to fill parameters of sell process' do
    mock(SellProcess).new(seller, buyer, confirmation).mock!.perform { OpenStruct.new count: 1 }
    OrderExecutor.new(stub!.delete.stub!.change.subject, confirmation).execute parties_determiner
  end
end
