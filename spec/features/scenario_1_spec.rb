require 'rails_helper'

CUR = '$'
DEL = ','
SEP = '.'

feature 'Scenario 1' do

  scenario "Matt the father is looking for a laptop for his son's graduation" do
    
    # visits CyberShop and logs in
    visit root_path
    expect(page).to have_text 'CYBERSHOP'
    click_link 'LOGIN'
    expect(page).to have_text 'Log in'
    page.fill_in 'Email', with: 'matt@example.com'
    page.fill_in 'Password', with: 'password'
    click_button 'Log in'

    # sees appropriate logged in content
    expect(page).to have_text 'Signed in successfully.'
    within('#top-navbar') do
      expect(page).to have_text 'USA'
      expect(page).to have_text 'Matt'
      expect(page).to have_text CUR+' 0'+SEP+'00'
    end

    expect_aphone_preorder_ad

    # sees Apricot Book thumbnail and clicks on the image
    expect(page).to have_text 'Apricot Book'
    expect(page).to have_css 'a[href^="/products/apricot-book"] > img[alt=Apricotbook]'
    find('#apricot-book-img-link').click

    # sees Apricot Book product page
    expect(page).to have_text 'Apricot Book'
    expect(page).to have_text 'Apricot inc.'
    expect(page).to have_text CUR+' 2'+DEL+'299'+SEP+'00'

    expect(page).to have_text '16 Core Processor'
    expect(page).to have_text 'High Quality Video and Speakers'
    expect(page).to have_text 'Waterproof'
    expect(page).to have_text '2 Year Warranty'

    expect_laptop_headphones_combo_deal

    # expect to see both deals on the Deals page
    click_link 'Deals'
    expect_aphone_preorder_ad
    expect_laptop_headphones_combo_deal
    click_button 'Add Both To Cart'

    # sees ad to waive the Pre-Order deposit and clicks 'Details'
    expect(page).to have_text 'Subtotal (2 items): '+CUR+' 2'+DEL+'299'+SEP+'00'
    within('.jumbotron') do
      expect(page).to have_text 'Good news Matt! Because you are a loyal Apricot customer, we will waive the regular '+CUR+'100 deposit for the aPhone 8 Pre-Order!'
      expect(page).to have_text 'Add your favorite color and memory option right now, and get it on the day of launch, guaranteed!'
      expect(page).to have_text 'Pre-Order aPhone 8'
      expect(page).to have_text CUR+' 0'+SEP+'00'
      expect(page).to have_link 'Details'
      expect(page).to have_button 'Add To Cart'
      click_link 'Details'
    end

    # sees same ad on product page with all the features and adds to cart
    expect(page).to have_text 'Good news Matt! Because you are a loyal Apricot customer, we will waive the regular '+CUR+'100 deposit for the aPhone 8 Pre-Order!'
    expect(page).to have_text 'Add your favorite color and memory option right now, and get it on the day of launch, guaranteed!'
    expect(page).to have_text 'Pre-Order aPhone 8'
    expect(page).to have_text CUR+' 100'+SEP+'00'
    expect(page).to have_text 'Voice Assistant Stoey'
    expect(page).to have_text 'Fireproof'
    expect(page).to have_text 'I10 Processor'
    expect(page).to have_text 'CHOOSE YOUR COLOR'
    expect(page).to have_text 'CHOOSE YOUR STORAGE'
    expect(page).to_not have_text 'Guaranteed availability on day of launch for just '+CUR+'100 in advance'
    click_link 'Add To Cart'
    
    # sees the three items in his shopping cart with the correct subtotal
    within '#shopping-cart' do

      expect(page).to have_text 'Price'
      expect(page).to have_text 'Quantity'

      within '#sounds-by-sir-simon' do
        expect(page).to have_text 'Sounds by Sir Simon'
        expect(page).to have_text 'by Apricot'
        expect(page).to have_text 'In Stock'
        expect(page).to have_text CUR+' 0'+SEP+'00'
        expect(page).to have_text CUR+' 299'+SEP+'00'
      end

      within '#apricot-book' do
        expect(page).to have_text 'Apricot Book'
        expect(page).to have_text 'by Apricot'
        expect(page).to have_text 'In Stock'
        expect(page).to have_text CUR+' 2'+DEL+'299'+SEP+'00'
      end

      within '#pre-order-aphone-8' do
        expect(page).to have_text 'Pre-Order aPhone 8'
        expect(page).to have_text 'by Apricot'
        expect(page).to have_text 'Coming Soon!'
        expect(page).to have_text CUR+' 0'+SEP+'00'
        expect(page).to have_text CUR+' 100'+SEP+'00'
      end

    end
    expect(page).to have_text 'Subtotal (3 items): '+CUR+' 2'+DEL+'299'+SEP+'00'
    expect(page).to have_link 'Proceed To Checkout'
    
    # BONUS: verify that removing a product maintains the state of other non-relevant deals
    within '#pre-order-aphone-8' do
      click_link 'Remove'
    end
    within '#sounds-by-sir-simon' do
      expect(page).to have_text 'Sounds by Sir Simon'
      expect(page).to have_text 'by Apricot'
      expect(page).to have_text 'In Stock'
      expect(page).to have_text CUR+' 0'+SEP+'00'
      expect(page).to have_text CUR+' 299'+SEP+'00'
    end
    
  end
  
end

# see aPhone 8 Pre-Order ad
def expect_aphone_preorder_ad
  within('#carousel') do
    expect(page).to have_text 'Pre-Order aPhone 8'
    expect(page).to have_text 'Guaranteed availability on day of launch for just '+CUR+'100 in advance'
    expect(page).to have_link 'Details'
  end
end

# sees the combo deal with the headphones and adds both to his cart
def expect_laptop_headphones_combo_deal
  within('.jumbotron') do
    expect(page).to have_text 'Get a FREE pair of Sounds by Sir Simon headphones when you purchase Apricot Book'
    expect(page).to have_text 'Apricot Book by Apricot Details '+CUR+' 2'+DEL+'299'+SEP+'00 + Sounds by Sir Simon by Apricot Details '+CUR+' 299'+SEP+'00'+CUR+' 0'+SEP+'00'
    expect(page).to have_button 'Add Both To Cart'
  end
end
