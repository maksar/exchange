require_relative '../spec_helper'
require_relative '../../lib/observable'

describe Observable do
  subject { Object.new.extend Observable }
  let(:handler) { double 'handler' }
  let(:change) { double 'change' }

  it 'executes add handler' do
    subject.subscribe_add handler
    mock(handler).call(change)
    subject.send :notify_add, change
  end

  it 'executes remove handler' do
    subject.subscribe_remove handler
    mock(handler).call(change)
    subject.send :notify_remove, change
  end
end
