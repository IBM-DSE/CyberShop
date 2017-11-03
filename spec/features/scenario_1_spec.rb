require 'rails_helper'

SPECIAL_OFFER_MESSAGE = 'Good news Matt! We have a SPECIAL OFFER just for you:We will waive the regular $100 deposit for the aPhone 8 Pre-Order!Order now, and get it on the day of launch, guaranteed!'

feature "Scenario 1: Matt the father is looking for a laptop for his son's graduation" do

  background do
    visit root_path
    expect(page).to have_text 'CYBERSHOP'
    expect(page).to have_link 'USA', class: 'dropdown-toggle'
  end

  scenario 'In Dollars' do

    scenario1('$', ',', '.')
    
  end

  scenario 'In Euros' do

    # switch to Euros
    click_link 'USA', class: 'dropdown-toggle'
    click_link 'EU'
    
    scenario1('€', '.', ',')

  end
  
end

def scenario1(cur, del, sep)

  special_offer_message = SPECIAL_OFFER_MESSAGE.gsub('$', cur)

  # logs in as Matt
  click_link 'Login'
  expect(page).to have_text 'Log in'
  page.fill_in 'Email', with: 'matt@example.com'
  page.fill_in 'Password', with: 'password'
  click_button 'Log in'

  # sees appropriate logged in content
  expect(page).to have_text 'Signed in successfully.'
  expect(page).to have_text 'Matt'

  expect_aphone_preorder_ad(cur, sep)

  # sees Apricot Book thumbnail and clicks on the image
  expect(page).to have_text 'Apricot Book'
  find('#apricot-book-img-link').click

  # sees Apricot Book product page
  expect(page).to have_text 'Apricot Book'
  expect(page).to have_text 'Apricot inc.'
  expect(page).to have_text cur+' 2'+del+'299'+sep+'00'

  expect(page).to have_text '16 Core Processor'
  expect(page).to have_text 'High Quality Video and Speakers'
  expect(page).to have_text 'Waterproof'
  expect(page).to have_text '2 Year Warranty'

  expect_laptop_headphones_combo_deal(cur, del, sep)

  # expect to see both deals on the Deals page
  click_link 'Deals'
  expect_aphone_preorder_ad(cur, sep)
  expect_laptop_headphones_combo_deal(cur, del, sep)
  click_button 'Add Both To Cart'

  # redirected to shopping cart
  expect(page).to have_text 'Shopping Cart'
  expect_apricot_book(cur, del, sep)
  expect_headphones(cur, sep)
  expect(page).to have_text 'Subtotal (2 items): '+cur+' 2'+del+'299'+sep+'00'
  
  # sees ad to waive the Pre-Order deposit and clicks on product name
  within '.deal' do
    expect(page).to have_text special_offer_message
    expect(page).to have_link 'Pre-Order aPhone 8'
    expect(page).to have_text 'by Apricot'
    expect(page).to have_text cur+' 100'+sep+'00'
    expect(page).to have_text cur+' 0'+sep+'00'
    expect(page).to have_button 'Add To Cart'
    click_link 'Pre-Order aPhone 8'
  end

  # sees same ad on product page with all the features and adds to cart
  expect(page).to have_text special_offer_message
  expect(page).to have_text 'Pre-Order aPhone 8'
  expect(page).to have_text cur+' 100'+sep+'00'
  expect(page).to have_text cur+' 0'+sep+'00'
  expect(page).to have_text 'Voice Assistant Stoey'
  expect(page).to have_text 'Fireproof'
  expect(page).to have_text 'I10 Processor'
  expect(page).to have_text 'CHOOSE YOUR COLOR'
  expect(page).to have_text 'CHOOSE YOUR STORAGE'
  expect(page).to_not have_text 'Guaranteed availability on day of launch for just '+cur+'100 in advance'
  click_link 'Add To Cart'

  # sees the three items in his shopping cart with the correct subtotal
  within '#shopping-cart' do

    expect(page).to have_text 'Price'
    expect(page).to have_text 'Quantity'

    expect_apricot_book(cur, del, sep)
    expect_headphones(cur, sep)

    within '#pre-order-aphone-8' do
      expect(page).to have_text 'Pre-Order aPhone 8'
      expect(page).to have_text 'by Apricot'
      expect(page).to have_text 'Coming Soon!'
      expect(page).to have_text cur+' 0'+sep+'00'
      expect(page).to have_text cur+' 100'+sep+'00'
    end

  end
  expect(page).to have_text 'Subtotal (3 items): '+cur+' 2'+del+'299'+sep+'00'
  expect(page).to have_link 'Proceed To Checkout'

  # BONUS: verify that removing a product maintains the state of other non-relevant deals
  within '#pre-order-aphone-8' do
    click_link 'Remove'
  end
  within '#sounds-by-sir-simon' do
    expect(page).to have_text 'Sounds by Sir Simon'
    expect(page).to have_text 'by Apricot'
    expect(page).to have_text 'In Stock'
    expect(page).to have_text cur+' 0'+sep+'00'
    expect(page).to have_text cur+' 299'+sep+'00'
  end
  
end

# see aPhone 8 Pre-Order ad
def expect_aphone_preorder_ad(cur, sep)
  expect(page).to have_text 'Pre-Order aPhone 8'
  expect(page).to have_text 'Guaranteed availability on day of launch'
  expect(page).to have_text cur+' 100'+sep+'00'
  expect(page).to have_link 'Details'
end

# sees the combo deal with the headphones and adds both to his cart
def expect_laptop_headphones_combo_deal(cur, del, sep)
  expect(page).to have_text 'FREE headphones with purchase of Apricot Book'
  expect(page).to have_text 'Apricot Book by Apricot '+cur+' 2'+del+'299'+sep+'00 + Sounds by Sir Simon by Apricot '+cur+' 299'+sep+'00'+cur+' 0'+sep+'00'
  expect(page).to have_button 'Add Both To Cart'
end

def expect_apricot_book(cur, del, sep)
  within '#apricot-book' do
    expect(page).to have_text 'Apricot Book'
    expect(page).to have_text 'by Apricot'
    expect(page).to have_text 'In Stock'
    expect(page).to have_text cur+' 2'+del+'299'+sep+'00'
  end
end

def expect_headphones(cur, sep)
  within '#sounds-by-sir-simon' do
    expect(page).to have_text 'Sounds by Sir Simon'
    expect(page).to have_text 'by Apricot'
    expect(page).to have_text 'In Stock'
    expect(page).to have_text cur+' 0'+sep+'00'
    expect(page).to have_text cur+' 299'+sep+'00'
  end
end