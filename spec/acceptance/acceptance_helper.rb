require 'rails_helper'

RSpec.configure do |config|
  Capybara.javascript_driver = :webkit

  config.include AcceptanceMacros, type: :feature

  config.use_transactional_fixtures = false

  config.before :each do
    if Capybara.current_driver == :rack_test
      DatabaseCleaner.strategy = :transaction
    else
      DatabaseCleaner.strategy = :truncation
    end
    DatabaseCleaner.start
  end

  config.after do
    DatabaseCleaner.clean
  end

end

