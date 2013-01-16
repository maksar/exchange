require_relative '../spec_helper'
require_relative '../../lib/portfolio'

describe Portfolio do
  subject { Portfolio.new([Stock.new('A', 10)]) }

  it 'is able to change stocks count' do
    subject.change_stocks('A', -2)
    subject.stocks_count('A').must_equal 8
  end

  it 'is able to create stocks' do
    subject.change_stocks('B', 3)
    subject.stocks_count('B').must_equal 3
  end
end
