require 'rails_helper'

RSpec.feature 'Admin', type: :feature do

  before do
    FactoryGirl.create(:admin_user)
  end

  scenario 'administrator visits the admin dashboard' do
    visit '/admin'

    expect(page).to have_text 'You need to sign in or sign up before continuing.'
    expect(page).to have_text 'Cyber World Login'

    page.fill_in 'Email*', with: 'admin@example.com'
    page.fill_in 'Password*', with: 'factorygirl'
    click_button 'Login'

    expect(page).to have_selector('#site_title')
    expect(find('#site_title')).to have_text 'Cyber World'
    expect(find('#tabs')).to have_text 'Dashboard'
    expect(find('#tabs')).to have_text 'Admin Users'
    expect(find('#tabs')).to have_text 'Machine Learning Services'
    expect(find('#tabs')).to have_text 'Ml Scoring Params'
    expect(find('#tabs')).to have_text 'Scoring'
  end
end
