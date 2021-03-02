cbt_username = ENV["CBT_USERNAME"]
cbt_authkey = ENV["CBT_AUTHKEY"]

Capybara.register_driver :selenium_cbt do |app|
  caps = Selenium::WebDriver::Remote::Capabilities.new

  caps["name"] = "Custom build"

  caps["record_video"] = "true"
  caps["record_network"] = "true"
  caps["nativeEvents"] = "true"
  caps["javascriptEnabled"] = "true"

  cbt_url = "http://#{cbt_username}:#{cbt_authkey}@hub.crossbrowsertesting.com/wd/hub"

  caps['browserName'] = 'Firefox'
  caps['platform'] = 'Mac OSX 10.12'

  Capybara::Selenium::Driver.new(
    app,
    browser: :remote,
    url: cbt_url,
    desired_capabilities: caps
  )
end

Capybara.default_driver = :selenium_cbt
