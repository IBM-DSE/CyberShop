require 'rails_helper'

INTRO_QUESTION = 'David, it looks you have been looking at smartphones. Can I help you?'
PERMISSION_QUESTION = 'Before we start may I use your personal data including your tweets to make product recommendations or special offers? Please answer full or none.'
SPHONE_FEATURE = "Singsong's sPhone8 carries Boxy - your travel companion it can translate any foreign text with the aim of a camera"

feature 'Scenario 2: David is looking for a smartphone for his travels', js: true do

  background do
    visit root_path
    expect(page).to have_text 'CYBERSHOP'
    expect(page).to have_link 'USA', class: 'dropdown-toggle'
  end

  scenario 'In Dollars' do

    scenario2('$', '.')

  end

  scenario 'In Euros' do

    # switch to Euros
    click_link 'USA', class: 'dropdown-toggle'
    click_link 'EU'
    expect(page).to have_text '€ 100,00'
    
    scenario2('€', ',')

  end

end

def scenario2(cur, sep)

  # logs in
  click_link 'Login'
  expect(page).to have_text 'Log in'
  page.fill_in 'Email', with: 'david@example.com'
  page.fill_in 'Password', with: 'password'
  click_button 'Log in'

  # sees home page
  expect(page).to have_text 'Signed in successfully.'
  expect(page).to have_text 'David'

  # navigate to Smartphones page
  within '#main-navbar' do
    click_link 'Categories'
    click_link 'Smartphones'
  end

  # expect Smartphones page
  expect(page).to have_text 'sPhone 8'
  expect(page).to have_text 'Pre-Order aPhone 8'
  expect(page).to have_text 'aPhone 7 GREEN'

  # expect chatbot to pop up, interact with none permission and navigate to aPhone 7 GREEN
  expect(page).to have_css '#chat-zone'
  within '#chat-window' do
    expect(page).to have_css "input[placeholder='Send a message...']"
    expect(page).to have_text INTRO_QUESTION
    page.fill_in 'Send a message...', with: 'okay'
    find('#chat-input').native.send_keys(:enter)
    expect(page).to have_text PERMISSION_QUESTION
    page.fill_in 'Send a message...', with: 'none'
    find('#chat-input').native.send_keys(:enter)
    expect(page).to have_text 'The A-phone Model GREEN has been popular on social media over the past few weeks. Can I tell you more?'
    page.fill_in 'Send a message...', with: 'sure'
    find('#chat-input').native.send_keys(:enter)
    expect(page).to have_text 'A portion of the proceeds from each phone is donated to help fight HIV/AIDS. Just click the image above for more information!'
    expect(page).to have_css 'a[href^="/products/aphone-7-green"] > img[src="/images/aPhone7GREEN.png"]'
    find('a[href^="/products/aphone-7-green"]').click
  end

  # expect aPhone 7 GREEN page
  expect(page).to have_text 'aPhone 7 GREEN'
  expect(page).to have_text 'Apricot inc.'
  expect(page).to have_text cur+' 699'+sep+'00'
  expect(page).to have_text 'High Quality Camera'
  expect(page).to have_text 'Waterproof'
  expect(page).to have_text 'I9 Processor'
  expect(page).to have_link 'Add To Cart'
  within('.deal') do
    expect(page).to have_text 'A portion of the proceeds from each phone is donated to help fight HIV/AIDS'
    expect(page).to_not have_text 'aPhone 7 GREEN'
    expect(page).to_not have_text 'Apricot inc.'
    expect(page).to_not have_text cur+' 699'+sep+'00'
    expect(page).to_not have_link 'Add To Cart'
  end

  # go back and do full consent conversation
  page.driver.go_back

  # expect chatbot to pop up, interact with none permission and navigate to aPhone 7 GREEN
  expect(page).to have_css '#chat-zone'
  within '#chat-window' do
    expect(page).to have_css "input[placeholder='Send a message...']"
    expect(page).to have_text INTRO_QUESTION
    page.fill_in 'Send a message...', with: 'okay'
    find('#chat-input').native.send_keys(:enter)
    expect(page).to have_text PERMISSION_QUESTION
    page.fill_in 'Send a message...', with: 'full'
    find('#chat-input').native.send_keys(:enter)
    expect(page).to have_text 'I see you have tweeted about phone features such as translation. Can I tell you more?'
    page.fill_in 'Send a message...', with: 'okay'
    find('#chat-input').native.send_keys(:enter)
    expect(page).to have_text 'The S-phone Model 8 is a good choice. It allows you to point your phone camera at foreign language text and it will give you a real-time translation.
Just click the image for more details!'
    expect(page).to have_css 'a[href^="/products/sphone-8"] > img[src="/images/sPhone8.jpg"]'
    find('a > img').click
  end

  # expect sPhone 8 page
  expect(page).to have_text 'sPhone 8'
  expect(page).to have_text 'Singsong inc.'
  expect(page).to have_text cur+' 799'+sep+'0'
  expect(page).to have_text 'Voice Assistant Boxy'
  expect(page).to have_text 'Fireproof'
  expect(page).to have_text 'S10 Processor'
  expect(page).to have_link 'Add To Cart'
  within('.deal') do
    expect(page).to have_text SPHONE_FEATURE
    expect(page).to_not have_text 'sPhone 8'
    expect(page).to_not have_text 'Singsong inc.'
    expect(page).to_not have_text cur+' 799'+sep+'00'
    expect(page).to_not have_link 'Add To Cart'
  end

end
