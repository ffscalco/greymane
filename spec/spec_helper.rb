require "codeclimate-test-reporter"
require 'simplecov'
require "coveralls"
CodeClimate::TestReporter.start

if ENV['coverage'] == 'on'
  SimpleCov.start 'rails' do
    minimum_coverage 100
  end
else
  SimpleCov.formatter = Coveralls::SimpleCov::Formatter
  SimpleCov.start do
    add_filter 'config/initializers'
  end

  Coveralls.wear!
end

RSpec.configure do |config|
  config.disable_monkey_patching!
  config.order = :random
  Kernel.srand config.seed
  config.filter_run focus: true
  config.run_all_when_everything_filtered = true
  config.expect_with :rspec do |expectations|
    expectations.syntax = :expect
  end
  config.mock_with :rspec do |mocks|
    mocks.syntax = :expect
    mocks.verify_partial_doubles = true
  end
  if config.files_to_run.one?
    config.default_formatter = 'doc'
  end
end
