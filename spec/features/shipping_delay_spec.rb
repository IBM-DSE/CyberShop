require 'rails_helper'

RSpec.feature 'Shipping Delay', type: :feature do
  
  scenario 'Predict Shipping Delay' do
    
    visit '/shipping'
    
    expect(page).to have_text 'Shipping Delay Predictor'
    expect(page).to have_button 'Predict Delay'
    
    if ENV['APP_URL'] || ENV['SHIPPING_USERNAME'] && ENV['SHIPPING_PASSWORD']
      
      expect_shipping_param_names
      expect_shipping_param_inputs
      
      fill_in 'totalCases', with: '2'
      fill_in 'totalWeight', with: '10'
      fill_in 'distance', with: '3000'
      select 'UNITED STATES', from: 'shipFrom'
      select 'CHINA', from: 'shipTo'
      select 'CA', from: 'shipFromState'
      select 'Clear', from: 'destWeatherConds'
      
      click_button 'Predict Delay'
      
      expect(page).to have_current_path shipping_score_path, ignore_query: true
      expect(page).to have_text 'Shipping Prediction'
      
      expect(page).to have_text 'Input Values'
      expect_shipping_param_names
      expect(page).to have_text '2'
      expect(page).to have_text '10.0'
      expect(page).to have_text '3000.0'
      expect(page).to have_text 'UNITED STATES'
      expect(page).to have_text 'CHINA'
      expect(page).to have_text 'CA'
      expect(page).to have_text 'NA'
      expect(page).to have_text 'Clear'
      
      expect(page).to have_text 'Prediction'
      expect(page).to have_text 'Delay: 2.12 days'
      
      expect(page).to have_link 'New Prediction'
      click_link 'New Prediction'
      
      expect_shipping_param_inputs 'Total Items' => 2 ,
                                   'Total Weight (kg)' => 10.0,
                                   'Distance (km)' => 3000.0,
                                   'Ship From (Country)' => 'UNITED STATES',
                                   'Ship To (Country)' => 'CHINA',
                                   'Ship From (State)' => 'CA',
                                   'Ship To (State)' => 'NA'
      
    else
      
      click_button 'Predict Delay'
      
      expect(page).to have_text 'ERROR: There is no available model for predicting shipping delay'
      expect(page).to have_text 'Shipping Delay Predictor'
      expect(page).to have_button 'Predict Delay'
    
    end
  end

end

# Assert correct order of shipping param names
def expect_shipping_param_names
  
  expect(page).to have_css 'table', text: /
    Total\sItems.+
    Total\sWeight\s\(kg\).+
    Ship\sFrom\s\(Country\).+
    Ship\sFrom\s\(State\).+
    Ship\sTo\s\(Country\).+
    Ship\sTo\s\(State\).+
    Distance\s\(km\).+
    Weather\scondition\sat\sdestination
  /x

end

def expect_shipping_param_inputs(values=nil)
  
  FIELD_PARAMS.each do |param|
    if values && values[param] 
      expect(page).to have_field param, with: values[param]
    else
      expect(page).to have_field param
    end
  end
  
  SELECT_PARAMS.each do |param, select_options|
    options = {with_options: select_options}
    options[:selected] = values[param] if values && values[param]
    expect(page).to have_select param, options
  end
  
end

FIELD_PARAMS = ['Total Items', 'Total Weight (kg)', 'Distance (km)']

SHIP_FROM_COUNTRIES = %w[AUSTRALIA HUNGARY INDONESIA IRELAND MALAYSIA MEXICO NEW ZEALAND PHILLIPINES SINGAPORE TAIWAN UNITED STATES]

SHIP_TO_COUNTRIES = %w[ABU DHABI ARGENTINA AUSTRALIA AUSTRIA BELGIUM BRAZIL CANADA CHILE CHINA COLOMBIA CROATIA CYPRUS CZECH REPUBLIC DENMARK ECUADOR EGYPT FRANCE GERMANY GREECE HUNGARY INDIA INDONESIA ISRAEL ITALY JAMAICA JAPAN KUWAIT MALAYSIA MEXICO MOROCCO NETHERLANDS NEW ZEALAND NORWAY PAKISTAN PHILLIPINES POLAND PORTUGAL ROMANIA SAUDI ARABIA SINGAPORE SLOVAKIA SLOVENIA SOUTH AFRICA SOUTH KOREA SPAIN SWEDEN SWITZERLAND TAIWAN THAILAND TURKEY UNITED ARAB EMIRATES UNITED KINGDOM UNITED STATES VIETNAM]

SHIP_FROM_STATES = %w[NA AZ CA DB JA MN NY]

SHIP_TO_STATES = %w[NA AB ACT AK AL AR AZ BC CA CO CT DC DE FL GA GP HI IA ID IL IN JA JAL KS KY LA MA MD ME MI MN MO MS NC ND NE NH NJ NM NSW NV NY OH OK ON OR PA PR QC RI RM SC SD TAM TN TX UT VA VIC VT WA WI WV WY ZH]

WEATHER_CONDITIONS = %w[unknown Clear Drizzle Fog Haze Heavy Rain Light Drizzle Light Freezing Fog Light Rain Light Rain Showers Light Snow Light Thunderstorms and Rain Mostly Cloudy Overcast Partly Cloudy Patches of Fog Rain Scattered Clouds Smoke]

SELECT_PARAMS = {
  'Ship From (Country)' => SHIP_FROM_COUNTRIES,
  'Ship To (Country)' => SHIP_TO_COUNTRIES,
  'Ship From (State)' => SHIP_FROM_STATES,
  'Ship To (State)' => SHIP_TO_STATES,
  'Weather condition at destination' => WEATHER_CONDITIONS
}