require 'rails_helper'

RSpec.feature 'Scenario 1', type: :feature do
  include_context 'app configured'

  scenario 'Customer visits home page and sees banner ad' do
    visit root_path

    within('#carousel') do
      expect(page).to have_text @product.name
      expect(page).to have_text @deal.description
      expect(page).to have_link 'Details', href: "/products/#{@product.friendly_id}"
      click_link 'Details'
    end

    expect(page).to have_text @product.name
    expect(page).to have_text "by #{@brand.name}"
    expect(page).to have_text @deal.description
    expect(page).to have_link 'Add To Cart'

  end

end
