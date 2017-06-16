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

    # sees home page
    expect(page).to have_text 'Signed in successfully.'
    within '#top-navbar' do
      expect(page).to have_text 'USA'
      expect(page).to have_text 'David'
      expect(page).to have_text '€ 0,00'
    end

    # navigate to Smartphones page
    within '#main-navbar' do
      click_link 'Categories'
      click_link 'Smartphones'
    end

    # expect Smartphones page
    expect(page).to have_text 'sPhone 8'
    expect(page).to have_text 'Pre-Order aPhone 8'
    expect(page).to have_text 'aPhone 7 GREEN'

    # expect chatbot to pop up
    expect(page).to have_css '#chat-zone'
    within '#chat-window' do
      expect(page).to have_text 'David, it looks you have been looking at smartphones. Can I help you?'
      page.fill_in 'Send a message...', with: 'okay'
      expect(page).to have_text 'Before we start may I use your personal data to make product recommendations? Please answer full or none.'
    end
    
  end
  
end
