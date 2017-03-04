require 'rubygems'
require 'pry'
require 'appium_lib'
require 'page-object'
require 'faker'
require 'require_all'

require_rel 'support'

def promote_methods
  Appium.promote_appium_methods RSpec::Core::ExampleGroup
  Appium.promote_appium_methods PageObject
end

RSpec.configure do |config|
  config.include PageObject::PageFactory

  PageObject.default_element_wait = 10
  PageObject.default_page_wait = 10
  config.color = true
  config.full_backtrace = true

  config.before(:all) do
    options = {
      caps: {
        :platformName => 'Android',
        :platformVersion => '4.3',
        :deviceName => 'Nexus 7',
        :avd => 'android',
        :app => './apk/omniNotes-debug-5.1.3.apk',
        :appPackage => 'it.feio.android.omninotes',
        :appActivity => '.MainActivity',
        :noReset => false,
        :fullReset => false,
        :newCommandTimeout => 600,
        :disableAndroidWatchers => true
      } ,
      launchTimeout: 200000,
    }
    @browser = Appium::Driver.new(options).start_driver
    promote_methods
  end

  config.after(:all) do
    @browser.quit unless @browser.nil?
  end
end
