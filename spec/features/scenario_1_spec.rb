require 'rails_helper'

RSpec.feature 'Scenario 1', type: :feature do
  # include_context 'app configured'

  scenario 'Customer visits home page and sees banner ad' do
    visit root_path

    within('#carousel') do
      expect(page).to have_text 'Pre-Order aPhone 8'
      expect(page).to have_text 'Lock in your order for just €100'
      expect(page).to have_link 'Details', href: '/products/pre-order-aphone-8'
      # click_link 'Details'
    end

    # expect(page).to have_text @product.name
    # expect(page).to have_text "#{@brand.name} inc."
    # expect(page).to have_text @deal.description
    # expect(page).to have_link 'Add To Cart'

  end

end
