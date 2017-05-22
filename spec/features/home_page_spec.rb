require 'rails_helper'

RSpec.feature 'Visiting the Home Page', type: :feature do
  scenario 'anonymous visitor sees the expected homepage content' do
    visit root_path
    expect(page).to have_text Rails.application.class.parent_name
  end
end
