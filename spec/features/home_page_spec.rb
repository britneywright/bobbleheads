require 'rails_helper'

feature "home page" do
  scenario "chooses a date" do
    visit root_path
    expect(page).to have_content "No."
  end
end
