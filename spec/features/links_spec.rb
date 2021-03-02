# frozen_string_literal: true

require "rails_helper"

RSpec.feature "Creating short links and using them for redirection" do
  context "when providing valid URL to redirect" do
    it "creates a new link and allows using it for redirection" do
      visit("/")

      original_url = "https://www.google.com/"
      fill_in("Original url", with: original_url)

      click_on("Create Short link")

      expect(page).to have_text("Short link was successfully created.")
      expect(page).to have_text("Original url: #{original_url}")

      short_link = find("#short_link")
      expect(short_link.text).to have_text(/http.+\/l\/\w{8}/)

      short_link.click

      expect(page.current_url).to eq(original_url)
    end
  end

  context "when providing an invalid URL to redirect" do
    it "renders errors" do
      visit("/")

      fill_in("Original url", with: "bad url")

      click_on("Create Short link")

      expect(page).to have_text("Original url must be a valid URL")
    end
  end
end
