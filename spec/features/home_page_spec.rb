require 'rails_helper'

describe "visiting home page" do
  
  after do
    Timecop.return
  end

  context "on day bobbleheads are available" do
    before do
      Timecop.freeze(Time.local(2015,04,14))
    end
    it "indicates bobbleheads are available" do
      visit root_path
      expect(page).to have_content "Yes!"
    end
  end
  
  context "on day bobbleheads are not available" do
    before do
      Timecop.freeze(Time.local(2015,03,28))
    end
    it "indicates bobbleheads are NOT available" do
      visit root_path
      expect(page).to have_content "No."
    end
  end
end
