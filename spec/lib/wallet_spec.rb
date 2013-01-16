require_relative '../spec_helper'
require_relative '../../lib/wallet'

describe Wallet do
  subject { Wallet.new 10 }
  it 'able to change funds' do
    subject.change_funds(-2)
    subject.funds.must_equal 8
  end
end
