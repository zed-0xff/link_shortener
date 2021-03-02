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

  platform = JSON.parse(File.read("spec/cbt_browsers.json")).sample
  browser = platform["browsers"].sample

  caps.merge!(platform["caps"])
  caps.merge!(browser["caps"])

  puts "Running CBT tests with caps: #{caps.inspect}"

  Capybara::Selenium::Driver.new(
    app,
    browser: :remote,
    url: cbt_url,
    desired_capabilities: caps
  )
end

Capybara.default_driver = :selenium_cbt

RSpec.configure do |config|
  config.after(:suite) do
    begin
      session_id = Capybara.current_session.driver.browser.session_id
      any_failed = RSpec.world.filtered_examples.values.flatten.any? do |x|
        x.metadata[:execution_result].status == :failed
      end
      score = any_failed ? "fail" : "pass"

      require 'rest-client'

      RestClient.put(
        "https://#{cbt_username}:#{cbt_authkey}@crossbrowsertesting.com/api/v3/selenium/#{session_id}",
        "action=set_score&score=#{score}"
      )
    rescue StandardError => e
      puts "Error while tracking score: #{e}"
    end
  end
end
