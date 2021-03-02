require "capybara"
require "capybara/rspec"

Capybara.server_host = "localhost"
Capybara.server_port = 7654

Capybara.server = :puma

Capybara.default_driver = :selenium_chrome
