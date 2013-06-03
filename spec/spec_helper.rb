ENV['RACK_ENV'] = 'test'
ENV['MAARK_TOKEN'] = '486CFDD0-BCAE-11E2-9E96-0800200C9A66'

require 'pry'
require 'pry-debugger'
require 'rack/test'
require 'minitest/spec'
require 'minitest/autorun'
require "minitest/reporters"

MiniTest::Reporters.use! [MiniTest::Reporters::SpecReporter.new, MiniTest::Reporters::GuardReporter.new]

def app
  App
end
