require 'rails_helper'

RSpec.feature 'Visiting the Home Page', type: :feature do
  include_context 'app configured'

  scenario 'anonymous visitor sees the expected homepage content' do
    visit root_path
    expect(page).to have_text app_name
    expect(page).to have_text "The World's Smartest Consumer Electronics Retail Store"

    within('#nav.nav.nav-tabs') do

      within('li#categories.dropdown') do
        expect(page).to have_link 'Categories', href: '#'
        expect(page).to have_selector 'ul.dropdown-menu'
        within('ul.dropdown-menu') do
          expect(page).to have_link 'Category 1', href: '#'
          expect(page).to have_link 'Category 2', href: '#'
          expect(page).to have_link 'Category 3', href: '#'
        end
      end

      expect(page).to have_link 'Brands', href: '#'
      expect(page).to have_link 'Deals', href: '#'
    end

  end
end
