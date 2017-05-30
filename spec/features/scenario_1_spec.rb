require 'rails_helper'

RSpec.feature 'Scenario 1', type: :feature do
  include_context 'app configured'

  scenario 'Customer visits home page and sees banner ad' do
    visit root_path

    within('#myCarousel') do
      expect(page).to have_text @deal.product.name
      expect(page).to have_text @deal.description
      expect(page).to have_link 'Details', href: "/products/#{@deal.product.id}"
      click_link 'Details'
    end

    expect(page).to have_text @deal.product.name
    expect(page).to have_text "by #{@deal.product.brand.name}"

  end

end
