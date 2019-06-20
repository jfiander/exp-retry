# frozen_string_literal: true

require 'bundler/setup'
Bundler.setup
require 'simplecov'
SimpleCov.start
SimpleCov.minimum_coverage(100)

require 'exp_retry'

RSpec.configure do |config|
end
