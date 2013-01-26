ENV["RAILS_ENV"] ||= 'test'
require 'simplecov'

SimpleCov.start do
  add_filter "/spec/spec_helper.rb"
end
require 'ostruct'

require 'rr'
require 'minitest/autorun'
require 'minitest/pride'
require 'minitest/ci'

class MiniTest::Unit::TestCase
  include RR::Adapters::MiniTest
end

def double name = ''
  eval <<-RUBY
    Object.new.tap do |double|
      class << double
        def to_s
          "<Double: #{name}>"
        end
      end
    end
  RUBY
end

if __FILE__ == $0
  Dir.glob('spec/**/*.rb').each { |file| require_relative file.gsub(/^spec\//,'') }
end
