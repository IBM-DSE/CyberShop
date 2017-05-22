require 'rails_helper'

RSpec.feature 'Admin', type: :feature do
  scenario 'administrator visits the admin dashboard' do
    visit '/admin'

    expect(page).to have_text 'You need to sign in or sign up before continuing.'

    fill_in 'Email', :with => 'admin@example.com'
    fill_in 'Password', :with => 'password'
    click_button 'Login'

    expect(page).to have_text 'Cyber World'
  end
end
