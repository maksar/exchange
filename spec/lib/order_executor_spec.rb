require_relative '../spec_helper'
require_relative '../../lib/order_executor'

describe OrderExecutor do
  let(:seller) { double 'seller' }
  let(:buyer) { double 'buyer' }
  let(:confirmation) { double 'confirmation' }
  let(:parties_determiner) { stub!.resolve { [seller, buyer] }.subject }
  let(:order_book) { double('order book') }

  it 'uses parties determiner to fill parameters of sell process' do
    mock(SellProcess).new(order_book, seller, buyer, confirmation).mock!.perform
    OrderExecutor.new(order_book, confirmation).execute parties_determiner
  end
end
