require 'rails_helper'

RSpec.feature 'Visiting the Home Page', type: :feature do
  include_context 'app configured'

  scenario 'customer visits the home page and sees deal in a banner at the top' do
    visit root_path
    within('#myCarousel') do
      Deal.all.each do |deal|
        expect(page).to have_text deal.product.name
        expect(page).to have_text deal.description
        expect(page).to have_link 'Details', href: "/products/#{deal.product.id}"
      end
    end
  end

  scenario 'anonymous visitor sees the expected homepage content' do
    visit root_path
    expect(page).to have_text app_name

    within('#nav.nav.nav-tabs') do

      within('li#categories') do
        expect(page).to have_link 'Categories', href: '#'
        expect(page).to have_selector 'ul.dropdown-menu'
        within('ul.dropdown-menu') do
          Category.all.each do |category|
            expect(page).to have_link category.name, href: '/categories/'+category.slug
          end
        end
      end

      within('li#brands') do
        expect(page).to have_link 'Brands', href: '#'
        expect(page).to have_selector 'ul.dropdown-menu'
        within('ul.dropdown-menu') do
          Brand.all.each do |brand|
            expect(page).to have_link brand.name, href: '/brands/'+brand.slug
          end
        end
      end

      expect(page).to have_link 'Deals', href: '#'
    end

  end
end
