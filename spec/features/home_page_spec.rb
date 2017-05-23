require 'rails_helper'

RSpec.feature 'Visiting the Home Page', type: :feature do
  include_context 'app configured'

  scenario 'anonymous visitor sees the expected homepage content' do
    visit root_path
    expect(page).to have_text app_name
    expect(page).to have_text "The World's Smartest Consumer Electronics Retail Store"
  end
end
