require_relative '../spec_helper'
require_relative '../../lib/observable'

describe Observable do
  subject { Object.new.extend Observable }
  let(:handler) { double 'handler' }
  let(:change) { double 'change' }

  [:add, :remove, :change].each do |message|
    eval <<-RUBY
      it 'executes #{message} handler' do
        subject.subscribe_#{message} handler
        mock(handler).call(change)
        subject.send :notify_#{message}, change
      end
    RUBY
  end
end
