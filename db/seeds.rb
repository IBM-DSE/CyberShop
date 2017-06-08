
AdminUser.create! email: 'admin@example.com', password: 'password', password_confirmation: 'password'

%w(Smartphones Laptops Headphones).each {|name| Category.create! name: name}
%w(Apricot Gazillion Singsong).each {|name| Brand.create! name: name}

Customer.create! name: 'John Smith'

Product.create! name:     'aPhone 7',
                category: Category.find_by_name('Smartphones'),
                brand:    Brand.find_by_name('Apricot'),
                image:    File.new(Rails.root.join('public', 'images', 'aPhone9.png'), 'r'),
                price:    699.00

aPhone8 = Product.create! name:     'aPhone 8',
                          category: Category.find_by_name('Smartphones'),
                          brand:    Brand.find_by_name('Apricot'),
                          image:    File.new(Rails.root.join('public', 'images', 'aPhone10-wide.jpg'), 'r'),
                          price:    100.00,
                          preorder: true

sPhone8 = Product.create! name:     'sPhone 8',
                          category: Category.find_by_name('Smartphones'),
                          brand:    Brand.find_by_name('Singsong'),
                          image:    File.new(Rails.root.join('public', 'images', 'sPhone8.jpg'), 'r'),
                          price:    799.00

honeycrisp = Product.create! name:     'Honeycrisp Pro',
                             category: Category.find_by_name('Laptops'),
                             brand:    Brand.find_by_name('Apricot'),
                             image:    File.new(Rails.root.join('public', 'images', 'FujiBook.jpg'), 'r'),
                             price:    2299.00

aHeadphones = Product.create! name:     'Sounds by Sir Simon',
                              category: Category.find_by_name('Headphones'),
                              brand:    Brand.find_by_name('Apricot'),
                              image:    File.new(Rails.root.join('public', 'images', 'aHeadphones.jpg'), 'r'),
                              price:    299.00

Deal.create! product:     aHeadphones,
             description: 'Get a FREE pair of Sounds by Sir Simon headphones when you purchase Honeycrisp Pro by Apricot!',
             trigger_product: honeycrisp,
             price:    0.00

Deal.create! product:     aPhone8,
             description: 'Pre-Order the upcoming aPhone 8 for just €100!'

Deal.create! product:     sPhone8,
             description: "Singsong's all-new sPhone8 has a voice assistant Boxy that can sing for you!"

Deal.create! product:         aPhone8,
             description:     'Good news! Because you are a loyal customer of the Apricot line and are about to purchase the Honeycrisp Book, we offer to waive the regular €100 Pre-Order. Add it to your cart right now for free!',
             special:         true,
             trigger_product: honeycrisp,
             price:    0.00
