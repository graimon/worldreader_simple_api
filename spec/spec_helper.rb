ENV['APP_ENV'] = "test"

require 'pry'
require 'rack/test'
require 'database_cleaner'
require 'faker'

require ::File.expand_path('../../environment',  __FILE__)

RSpec.configure do |config|
  
  config.before(:suite) do
    DatabaseCleaner[:sequel].strategy = :truncation
    DatabaseCleaner.clean_with(:truncation)
  end

  # Set proper tenant
  config.around :each do |example|
    DatabaseCleaner[:sequel].db = DB
    DatabaseCleaner.cleaning do
      example.run
    end
  end

  config.expect_with :rspec do |expectations|
    # Better error messages with chained expectations
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    # Prevents you from stubbing a method that does not exist on a real object
    mocks.verify_partial_doubles = true
  end

  config.disable_monkey_patching!
  config.order = :random

end
