require "ngrok/tunnel"

RSpec.configure do |config|
  # Tells capybara to access the server via an ngrok tunnel.
  original_app_host = Capybara.app_host
  config.around(:each) do |example|
    raise "Capybara.server_port is undefined" unless Capybara.server_port
    Ngrok::Tunnel.start(port: Capybara.server_port, authtoken: ENV["NGROK_AUTHTOKEN"]) unless Ngrok::Tunnel.running?

    Capybara.app_host = Ngrok::Tunnel.ngrok_url_https

    example.run

    Capybara.app_host = original_app_host
  end

  # If `NGROK_AUTHTOKEN` isn't provided then a new tunnel will be started with each
  # test to overcome free ngrok version limitations (40 connections per minute).
  config.after(ENV["NGROK_AUTHTOKEN"] ? :suite : :each) { Ngrok::Tunnel.stop }
end
