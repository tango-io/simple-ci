require 'headless'

RSpec.configure do |config|
  config.before :each, :js do
    Capybara.current_driver = :webkit
    unless OS.mac?
      headless = Headless.new
      headless.start
    end
  end

  config.before :each, :selenium do
    Capybara.current_driver = :selenium
    unless OS.mac?
      headless = Headless.new
      headless.start
    end
  end
end
