require 'rails_helper'

RSpec.feature 'Scenario 1', type: :feature do

  scenario "Matt the father is looking for a laptop for his son's graduation" do
    
    # visits CyberShop and logs in
    visit root_path
    expect(page).to have_text 'CYBERSHOP'
    click_link 'LOGIN'
    expect(page).to have_text 'Log in'
    page.fill_in 'Email', with: 'matt@example.com'
    page.fill_in 'Password', with: 'password'
    click_button 'Log in'

    within('#top-navbar') do
      expect(page).to have_text 'USA'
      expect(page).to have_text 'Matt'
      expect(page).to have_text '€ 0,00'
    end

    # sees aPhone 8 Pre-Order ad
    within('#carousel') do
      expect(page).to have_text 'Pre-Order aPhone 8'
      expect(page).to have_text 'Lock in your order for just €100'
      expect(page).to have_link 'Details'
    end

    # sees Apricot Book thumbnail and clicks on the image
    expect(page).to have_text 'Apricot Book'
    expect(page).to have_css 'a[href^="/products/apricot-book"] > img[alt=Apricotbook]'
    find('#apricot-book-img-link').click

    # sees Apricot Book product page
    expect(page).to have_text 'Apricot Book'
    expect(page).to have_text 'Apricot inc.'
    expect(page).to have_text '€ 2.299,00'

    expect(page).to have_text '16 Core Processor'
    expect(page).to have_text 'High Quality Video and Speakers'
    expect(page).to have_text 'Waterproof'
    expect(page).to have_text '2 Year Warranty'

    # sees the combo deal with the headphones and adds both to his cart
    expect(page).to have_text 'Get a FREE pair of Sounds by Sir Simon headphones when you purchase Apricot Book'
    expect(page).to have_button 'Add Both To Cart'
    click_button 'Add Both To Cart'

    # sees ad to waive the Pre-Order deposit and clicks 'Details'
    expect(page).to have_text 'Subtotal (2 items): € 2.299,00'
    within('.jumbotron') do
      expect(page).to have_text 'Good news! Because you are a loyal customer of the Apricot line and are about to purchase the Apricot Book, we offer to waive the regular €100 aPhone 8 Pre-Order deposit. Add it to your cart right now for free!'
      expect(page).to have_text 'Pre-Order aPhone 8'
      expect(page).to have_text '€ 0,00'
      expect(page).to have_link 'Details'
      expect(page).to have_button 'Add To Cart'
      click_link 'Details'
    end

    # sees product page with all the features and adds to cart
    expect(page).to have_text 'Pre-Order aPhone 8'
    expect(page).to have_text '€ 100,00'
    expect(page).to have_text 'Voice Assistant Stoey'
    expect(page).to have_text 'Fireproof'
    expect(page).to have_text 'I10 Processor'
    expect(page).to have_text 'CHOOSE YOUR COLOR'
    expect(page).to have_text 'CHOOSE YOUR STORAGE'
    click_link 'Add To Cart'
    
    # sees the three items in his shopping cart with the correct subtotal
    within '#shopping-cart' do

      expect(page).to have_text 'Price'
      expect(page).to have_text 'Quantity'
      
      expect(page).to have_text 'Sounds by Sir Simon'
      expect(page).to have_text 'by Apricot'
      expect(page).to have_text 'In Stock'

      expect(page).to have_text 'Apricot Book'
      expect(page).to have_text 'by Apricot'
      expect(page).to have_text 'In Stock'

      expect(page).to have_text 'Pre-Order aPhone 8'
      expect(page).to have_text 'by Apricot'
      expect(page).to have_text 'Coming Soon!'
      
    end
    expect(page).to have_text 'Subtotal (3 items): € 2.299,00'
    expect(page).to have_link 'Proceed To Checkout'
    
  end
  
end
