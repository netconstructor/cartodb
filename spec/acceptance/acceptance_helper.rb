require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require "steak"
require 'capybara/rails'
require "capybara/dsl"
require "selenium-webdriver"

# Put your acceptance spec helpers inside /spec/acceptance/support
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

Capybara.default_driver    = :selenium
# Capybara.default_host      = 'example.com'
# Capybara.server_port       = 9887
# Capybara.app_host          = "http://#{Capybara.default_host}:#{Capybara.server_port}"
Capybara.default_wait_time = 10

RSpec.configuration.include Capybara, :type => :acceptance

RSpec.configure do |config|

  config.before(:each) do
    Rails.cache.clear
  end

  config.after(:each) do
    case page.driver.class
    when Capybara::Driver::RackTest
      page.driver.rack_mock_session.clear_cookies
    when Capybara::Driver::Culerity
      page.driver.browser.clear_cookies
    when Capybara::Driver::Selenium
      page.driver.cleanup!
    end
    Capybara.use_default_driver
  end

end