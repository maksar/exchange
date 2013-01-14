ENV["RAILS_ENV"] ||= 'test'
require 'simplecov'
require 'pry'

SimpleCov.start

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
