require 'rails_helper'

RSpec.feature 'Visiting the Home Page', type: :feature do
  include_context 'app configured'

  scenario 'anonymous visitor sees the expected homepage content' do
    visit root_path
    expect(page).to have_text app_name

    within('#nav.nav.nav-tabs') do

      within('li#categories.dropdown') do
        expect(page).to have_link 'Categories', href: '#'
        expect(page).to have_selector 'ul.dropdown-menu'
        within('ul.dropdown-menu') do
          Category.all.each do |category|
            expect(page).to have_link category.name, href: '#'
          end
        end
      end

      expect(page).to have_link 'Brands', href: '#'
      expect(page).to have_link 'Deals', href: '#'
    end

  end
end
