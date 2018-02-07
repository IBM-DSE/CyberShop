require 'rails_helper'

RSpec.feature 'Shipping Delay', type: :feature do

  before do
    visit '/admin/machine_learning_services/2'

    expect(page).to have_text 'You need to sign in or sign up before continuing.'
    expect(page).to have_text 'CyberShop Login'

    page.fill_in 'Email*', with: 'admin@example.com'
    page.fill_in 'Password*', with: ENV['ADMIN_PASSWORD'] || 'password'
    click_button 'Login'
  end

  scenario 'Predict Shipping Delay' do

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

SHIP_FROM_COUNTRIES = %w[AUSTRALIA HUNGARY INDONESIA IRELAND MALAYSIA MEXICO NEW ZEALAND PHILLIPINES SINGAPORE TAIWAN UNITED STATES]

SHIP_TO_COUNTRIES = %w[ABU DHABI ARGENTINA AUSTRALIA AUSTRIA BELGIUM BRAZIL CANADA CHILE CHINA COLOMBIA CROATIA CYPRUS CZECH REPUBLIC DENMARK ECUADOR EGYPT FRANCE GERMANY GREECE HUNGARY INDIA INDONESIA ISRAEL ITALY JAMAICA JAPAN KUWAIT MALAYSIA MEXICO MOROCCO NETHERLANDS NEW ZEALAND NORWAY PAKISTAN PHILLIPINES POLAND PORTUGAL ROMANIA SAUDI ARABIA SINGAPORE SLOVAKIA SLOVENIA SOUTH AFRICA SOUTH KOREA SPAIN SWEDEN SWITZERLAND TAIWAN THAILAND TURKEY UNITED ARAB EMIRATES UNITED KINGDOM UNITED STATES VIETNAM]

SHIP_FROM_STATES = %w[NA AZ CA DB JA MN NY]

SHIP_TO_STATES = %w[NA AB ACT AK AL AR AZ BC CA CO CT DC DE FL GA GP HI IA ID IL IN JA JAL KS KY LA MA MD ME MI MN MO MS NC ND NE NH NJ NM NSW NV NY OH OK ON OR PA PR QC RI RM SC SD TAM TN TX UT VA VIC VT WA WI WV WY ZH]

WEATHER_CONDITIONS = %w[unknown Clear Drizzle Fog Haze Heavy Rain Light Drizzle Light Freezing Fog Light Rain Light Rain Showers Light Snow Light Thunderstorms and Rain Mostly Cloudy Overcast Partly Cloudy Patches of Fog Rain Scattered Clouds Smoke]