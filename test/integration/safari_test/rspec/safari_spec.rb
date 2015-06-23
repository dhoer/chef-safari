# http://elementalselenium.com/tips/69-safari
require 'rspec_helper'
require 'rspec'
require 'selenium-webdriver'

include RSpec::Matchers

RSpec.configure { |c| c.formatter = 'documentation' }

def setup
  @driver = Selenium::WebDriver.for :safari
end

def teardown
  @driver.quit
end

def run
  setup
  yield
  teardown
end

run do
  @driver.get 'http://the-internet.herokuapp.com'
  expect(@driver.title).to eql 'The Internet'
end
