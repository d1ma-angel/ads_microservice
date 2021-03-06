# frozen_string_literal: true

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner[:active_record].strategy = :transaction
    DatabaseCleaner[:active_record].clean_with(:truncation)
  end

  config.before(:all) do
    DatabaseCleaner.start
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning { example.run }
  end

  config.after(:all) do
    DatabaseCleaner.clean
  end
end
