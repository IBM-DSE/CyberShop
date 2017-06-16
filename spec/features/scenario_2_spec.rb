require 'rails_helper'

RSpec.feature 'Scenario 2', type: :feature do

  scenario 'David the son is looking for a phone with cool new features' do
    
    # visits CyberShop and logs in
    visit root_path
    expect(page).to have_text 'CYBERSHOP'
    click_link 'LOGIN'
    expect(page).to have_text 'Log in'
    page.fill_in 'Email', with: 'david@example.com'
    page.fill_in 'Password', with: 'password'
    click_button 'Log in'

    within('#top-navbar') do
      expect(page).to have_text 'USA'
      expect(page).to have_text 'David'
      expect(page).to have_text '€ 0,00'
    end

    # sees aPhone 8 Pre-Order ad
    within('#carousel') do
      expect(page).to have_text 'Pre-Order aPhone 8'
      expect(page).to have_text 'Lock in your order for just €100'
      expect(page).to have_link 'Details'
    end
    
  end
  
end
