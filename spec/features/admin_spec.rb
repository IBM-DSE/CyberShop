require 'rails_helper'

RSpec.feature 'Admin', type: :feature do
  # include_context 'app configured'

  before do
    visit '/admin'

    expect(page).to have_text 'You need to sign in or sign up before continuing.'
    expect(page).to have_text 'CyberShop Login'

    page.fill_in 'Email*', with: 'admin@example.com'
    page.fill_in 'Password*', with: 'password'
    click_button 'Login'
  end

  scenario 'Dashboard' do

    expect(page).to have_selector('#site_title')
    expect(find('#site_title')).to have_link 'CyberShop', href: '/'
    expect(find('#tabs')).to have_text 'Dashboard'
    expect(find('#tabs')).to have_text 'Admin Users'
    expect(find('#tabs')).to have_text 'Machine Learning Services'
    expect(find('#tabs')).to have_text 'Ml Scoring Params'
    expect(find('#tabs')).to have_text 'Scoring'
  end

  scenario 'Categories' do

    within '#header' do
      within '#tabs' do
        expect(page).to have_link 'Categories', href: '/admin/categories'
      end
    end

  #   click_link 'Categories'
  #   within 'h2' do
  #     expect(page).to have_content 'Categories'
  #   end
  #   within 'table' do
  #     Category.all.each do |category|
  #       expect(page).to have_text category.name
  #       find('tr', text: category.name).click_link 'View'
  #       expect(page).to have_text category.name
  #     end
  #   end
  # 
  # end
  # 
  # scenario 'Brands' do
  # 
  #   within '#header' do
  #     within '#tabs' do
  #       expect(page).to have_link 'Brands', href: '/admin/brands'
  #     end
  #   end
  # 
  #   click_link 'Brands'
  #   within 'h2' do
  #     expect(page).to have_content 'Brands'
  #   end
  #   within 'table' do
  #     Brand.all.each do |brand|
  #       expect(page).to have_text brand.name
  #       find('tr', text: brand.name).click_link 'View'
  #       expect(page).to have_text brand.name
  #     end
  #   end

  end

end
