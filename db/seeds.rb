AdminUser.create! email: 'admin@example.com', password: 'password', password_confirmation: 'password'

%w(Smartphones Laptops Headphones).each {|name| Category.create! name: name}
%w(Apricot Gazillion Singsong).each {|name| Brand.create! name: name}

Customer.create! name: 'David', email: 'david@example.com', password: 'password', password_confirmation: 'password', interest: 'smartphones'
Customer.create! name: 'Keith', email: 'keith@example.com', password: 'password', password_confirmation: 'password', interest: 'laptops'

aPhone7 = Product.create! name:     'aPhone 7',
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

apricotBook = Product.create! name:     'Apricot Book',
                              category: Category.find_by_name('Laptops'),
                              brand:    Brand.find_by_name('Apricot'),
                              image:    File.new(Rails.root.join('public', 'images', 'apricotbook.jpg'), 'r'),
                              price:    2299.00

aHeadphones = Product.create! name:     'Sounds by Sir Simon',
                              category: Category.find_by_name('Headphones'),
                              brand:    Brand.find_by_name('Apricot'),
                              image:    File.new(Rails.root.join('public', 'images', 'aHeadphones.jpg'), 'r'),
                              price:    299.00

Deal.create! product:     aPhone8,
             description: 'Pre-Order for just €100'

Deal.create! product:         aHeadphones,
             description:     'Get a FREE pair of Sounds by Sir Simon headphones when you purchase Apricot Book by Apricot!',
             trigger_product: apricotBook,
             price:           0.00

Deal.create! product:     sPhone8,
             description: "Smithsong's sPhone8 carries Boxy - a travel companion that can translate any foreign text with the aim of a camera"

Deal.create! product:         aPhone8,
             description:     'Good news! Because you are a loyal customer of the Apricot line and are about to purchase the Apricot Book, we offer to waive the regular €100 Pre-Order fee. Add it to your cart right now for free!',
             special:         true,
             trigger_product: apricotBook,
             price:           0.00

CSV.foreach('db/seed_data/WEX_output.csv', headers: true) do |row|
  data               = row.to_hash
  data['frequency']  = data['frequency'].to_i
  data['aphone']     = data['aphone'].to_i
  data['sphone']     = data['sphone'].to_i
  data['product_id'] = data['aphone'] > data['sphone'] ? aPhone7.id : sPhone8.id
  TrendingTopic.create! data
end