require 'rails_helper'

RSpec.feature 'Admin', type: :feature do

  before do
    visit '/admin'

    expect(page).to have_text 'You need to sign in or sign up before continuing.'
    expect(page).to have_text 'CyberShop Login'

    page.fill_in 'Email*', with: 'admin@example.com'
    page.fill_in 'Password*', with: ENV['ADMIN_PASSWORD'] || 'password'
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

  scenario 'Predict Shipping Delay' do
    
    visit '/admin/machine_learning_services/2'
    
    expect(page).to have_text 'Machine Learning Service Details'
    expect(page).to have_text 'Name Supply Chain'
    expect(page).to have_text 'Hostname ibm-watson-ml.mybluemix.net'
  
    expect(page).to have_text 'Test Scoring'
    expect(page).to have_text 'Ship from (country)'
  
    within(page.first('form', text: 'Ship from (country)')) do
    
      expect(page).to have_text 'Total items'
      expect(page).to have_text 'Total weight (kg)'
      expect(page).to have_text 'Distance (km)'
      expect(page).to have_text 'Ship from (country)'
      expect(page).to have_select 'shipFrom', with_options: SHIP_FROM_COUNTRIES
      expect(page).to have_text 'Ship to (country)'
      expect(page).to have_select 'shipTo', with_options: SHIP_TO_COUNTRIES
      expect(page).to have_text 'Ship from (state)'
      expect(page).to have_select 'shipFromState', with_options: SHIP_FROM_STATES
      expect(page).to have_text 'Ship to (state)'
      expect(page).to have_select 'shipToState', with_options: SHIP_TO_STATES
      expect(page).to have_text 'Weather condition at destination'
      expect(page).to have_select 'destWeatherConds', with_options: WEATHER_CONDITIONS
    
      fill_in 'totalCases', with: '10'
      fill_in 'totalWeight', with: '100'
      fill_in 'distance', with: '1000'
      select 'Clear', from: 'destWeatherConds'
    
      click_button 'Get Score'
    end
  end

end
