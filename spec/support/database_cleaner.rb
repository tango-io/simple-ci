RSpec.configure do |config|

  def js_example?(example)
    example.metadata[:js] || example.metadata[:selenium]
  end


  config.use_transactional_fixtures = false
  config.use_transactional_examples = false

  DatabaseCleaner.strategy = :truncation

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
