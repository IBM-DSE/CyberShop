require 'rails_helper'

RSpec.feature 'Visiting the Home Page', type: :feature do
  include_context 'app configured'

  scenario 'anonymous visitor sees the expected homepage content' do
    visit root_path
    expect(page).to have_text app_name
    expect(page).to have_text "The World's Smartest Consumer Electronics Retail Store"

    expect(page).to have_selector '#nav.nav.nav-tabs'
    nav = find('#nav')
    expect(nav).to have_link 'Categories', href: '#'
    expect(nav).to have_link 'Brands', href: '#'
    expect(nav).to have_link 'Deals', href: '#'
  end
end
