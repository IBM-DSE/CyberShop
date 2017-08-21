require 'rails_helper'

RSpec.feature 'Visiting the Home Page', type: :feature do
  background do
    visit root_path
  end

  scenario 'anonymous visitor sees the expected homepage content' do
    expect(page).to have_text 'CYBERSHOP'

    within('#main-navbar') do

      within('li#categories') do
        expect(page).to have_link 'Categories', href: '#', class: 'dropdown-toggle'
        click_link 'Categories'
        expect(page).to have_selector 'ul.dropdown-menu'
        within('ul.dropdown-menu') do
          %w(Smartphones Tablets Laptops Headphones).each do |category|
            expect(page).to have_link category, href: '/categories/'+category.downcase
          end
        end
      end

      within('li#brands') do
        expect(page).to have_link 'Brands', href: '#'
        click_link 'Brands'
        expect(page).to have_selector 'ul.dropdown-menu'
        within('ul.dropdown-menu') do
          %w(Apricot Gazillion Singsong).each do |brand|
            expect(page).to have_link brand, href: '/brands/'+brand.downcase
          end
        end
      end

      expect(page).to have_link 'Deals', href: '/deals'
    end

    within('#carousel') do
      expect(page).to have_text 'Pre-Order aPhone 8'
      expect(page).to have_text 'Guaranteed availability on day of launch for just €100 in advance'
      expect(page).to have_link 'Details', href: '/products/pre-order-aphone-8'
    end
  end

end
