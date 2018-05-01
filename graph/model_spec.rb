require_relative '../lib/model/model_builder'
require 'selenium-webdriver'


Selenium::WebDriver::Chrome.driver_path = './chromedriver'
@driver = Selenium::WebDriver.for :chrome

def navigate_to_autogravity
  @driver.get('http://www.autogravity.com')
  sleep 5
  true
end

def click_on_login
  #

  @driver.find_element(:xpath, "//*[@id='content']/div/div/div[2]/header/div/div[2]/div[1]/div/a[2]").click
  sleep 5
rescue Selenium::WebDriver::Error::NoSuchElementError
  false
rescue Selenium::WebDriver::Error::StaleElementReferenceError
  false
end

def login_correctly
  @driver.find_element(:id, 'email').send_keys('fake_fico_800@autogravity.com')
  sleep 5
  @driver.find_element(:id, 'password').send_keys('Welcome1')
  sleep 5
  @driver.find_element(:xpath, '/html/body/div[2]/div/div/div/form/div[3]/button[2]')
  sleep 5
rescue Selenium::WebDriver::Error::NoSuchElementError
  false
rescue Selenium::WebDriver::Error::StaleElementReferenceError
  false
end

def select_make
  @driver.find_elements(:css, 'div.desktopOnly___3DQBl > div > button').first.click
  sleep 5
  true
rescue Selenium::WebDriver::Error::NoSuchElementError
  false
rescue Selenium::WebDriver::Error::StaleElementReferenceError
  false
end

def select_model
  coll = @driver.find_elements(:css, "[data-gtm='selectedMake']").sample
  coll.click
  sleep 10
  true
rescue Selenium::WebDriver::Error::NoSuchElementError
  false
rescue Selenium::WebDriver::Error::StaleElementReferenceError
  false
end

def select_trim
  @driver.find_element(:class, 'intercom-notifications-dismiss-button').click
  sleep 10
  coll = @driver.find_elements(:css, "div[data-gtm='selectedModel'] img[itemprop='image']").sample
  coll.click
  sleep 10
  true
rescue Selenium::WebDriver::Error::NoSuchElementError
  p 'no element'
  false
rescue Selenium::WebDriver::Error::StaleElementReferenceError
  false
end

def raise_exp
  raise Exception
  true
rescue Exception
  false
end

model = ModelBuilder.new
model.add_node('Start')
model.add_node('Home Page')
model.add_node('Login Page')
model.add_node('Select Make')
model.add_node('Select Model')
model.add_node('Select Trim')
# model.add_node("Review Vehicle")
# model.add_node("Review Details")
model.add_edge('Start', 'Home Page', navigate_to_autogravity)
model.add_edge('Home Page', 'Login Page', true, 'Clicked Login')
model.add_edge('Login Page', 'Home Page', true, 'Logged in Correctly')
# model.add_edge("Login Page", "Login Page", true, "Failed to Login")
model.add_edge('Home Page', 'Select Make', select_make, 'Picked Make')
model.add_edge('Select Make', 'Select Model', select_model, 'Picked Model')
model.add_edge('Select Model', 'Select Trim', raise_exp)
model.add_edge('Select Trim', 'Review Vehicle', raise_exp)
# model.add_edge("Review Vehicle", "Review Details", true)
model.output_png('output/model.png')
