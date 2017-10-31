require 'rails_helper'

feature 'Visiting the Home Page' do
  background do
    visit root_path
  end

  scenario 'anonymous visitor sees the expected homepage content' do
    expect(page).to have_text 'CYBERSHOP'

    within('#main-navbar') do

      within('li#categories') do
        expect(page).to have_link 'Categories', href: '#', class: 'dropdown-toggle'
        click_link 'Categories'
        expect(page).to have_selector 'ul.dropdown-menu'
        within('ul.dropdown-menu') do
          %w(Smartphones Tablets Laptops Headphones).each do |category|
            expect(page).to have_link category
          end
        end
      end

      within('li#brands') do
        expect(page).to have_link 'Brands', href: '#'
        click_link 'Brands'
        expect(page).to have_selector 'ul.dropdown-menu'
        within('ul.dropdown-menu') do
          %w(Apricot Gazillion Singsong).each do |brand|
            expect(page).to have_link brand
          end
        end
      end

      expect(page).to have_link 'Deals'
    end

    # expect_aphone_preorder_ad
  end
  
  # TODO: move this to scenario 1 spec
  # scenario 'anonymous visitor checks the deals page' do
  #   click_link 'Deals'
  # 
  #   expect_aphone_preorder_ad
  #   
  #   within('.jumbotron') do
  #     expect(page).to have_text 'Get a FREE pair of Sounds by Sir Simon headphones when you purchase Apricot Book'
  #     expect(page).to have_text 'Apricot Book by Apricot Details € 2.299,00 + Sounds by Sir Simon by Apricot Details € 299,00€ 0,00'
  #     expect(page).to have_button 'Add Both To Cart'
  #   end
  #   
  # end

end


# def expect_aphone_preorder_ad
#   # sees aPhone 8 Pre-Order ad
#   within('#carousel') do
#     expect(page).to have_text 'Pre-Order aPhone 8'
#     expect(page).to have_text 'Guaranteed availability on day of launch for just €100 in advance'
#     expect(page).to have_link 'Details'
#   end
# end