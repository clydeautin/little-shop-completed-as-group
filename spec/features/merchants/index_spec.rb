require "rails_helper"

RSpec.describe "the merchant index page" do

  it "I see a list of the names of all of merchants" do
    merchant = create(:merchant)
    merchant2 = create(:merchant)

    visit merchants_path

    expect(page).to have_content(merchant.name)
    expect(page).to have_content(merchant2.name)
  end
end
