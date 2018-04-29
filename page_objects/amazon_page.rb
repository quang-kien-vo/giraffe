require 'singleton'
require 'selenium-webdriver'


class AmazonPage
  include Singleton

  attr_accessor :driver

  def initialize
    Selenium::WebDriver::Chrome.driver_path="./chromedriver"
    @driver = Selenium::WebDriver.for :chrome
  end

  def navigate_to_amazon
    @driver.get("https://www.amazon.com/")
    puts 'https://www.amazon.com/'
    true
  end

  def search_for_paint
    @driver.find_element(:id, "twotabsearchtextbox").send_keys("paint")
  end
end
