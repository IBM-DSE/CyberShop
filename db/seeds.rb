admin_password =  ENV['ADMIN_PASSWORD'] || 'password'
AdminUser.create! email: 'admin@example.com', password: admin_password, password_confirmation: admin_password

%w(Smartphones Tablets Laptops Headphones).each {|name| Category.create! name: name}
%w(Apricot Gazillion Singsong).each {|name| Brand.create! name: name}

Customer.create! name:   'Matt', email: 'matt@example.com', password: 'password', password_confirmation: 'password', interest: 'laptops',
                 gender: 'M', age_group: '45-54', education: 'Doctorate', profession: 'Executive', income: 200000, switcher: 0, last_purchase: 3, annual_spend: 1200
Customer.create! name: 'David', email: 'david@example.com', password: 'password', password_confirmation: 'password', interest: 'smartphones'
                 # gender: 'M', age_group: '25-34', education: 'Masters', profession: 'Programmer', income: 40000, switcher: 1, last_purchase: 5, annual_spend: 200
Customer.create! name: 'Keith', email: 'keith@example.com', password: 'password', password_confirmation: 'password', interest: 'laptops'


# LAPTOPS

songbook = Product.create name:     'Song Book',
                          category: Category.find_by_name('Laptops'),
                          brand:    Brand.find_by_name('Singsong'),
                          image:    File.new(Rails.root.join('public', 'images', 'SongBook.jpg'), 'r'),
                          price:    999.00
songbook.features.build description: '8 Core Processor'
songbook.features.build description: 'High Quality and Speakers'
songbook.features.build description: 'Fireproof'
songbook.features.build description: '2 Year Warranty'
songbook.save

apricotbook = Product.create name:     'Apricot Book',
                             category: Category.find_by_name('Laptops'),
                             brand:    Brand.find_by_name('Apricot'),
                             image:    File.new(Rails.root.join('public', 'images', 'apricotbook.jpg'), 'r'),
                             price:    2299.00
apricotbook.features.build description: '16 Core Processor'
apricotbook.features.build description: 'High Quality Video and Speakers'
apricotbook.features.build description: 'Waterproof'
apricotbook.features.build description: '2 Year Warranty'
apricotbook.save

Product.create name:     'aBook Air',
               category: Category.find_by_name('Laptops'),
               brand:    Brand.find_by_name('Apricot'),
               image:    File.new(Rails.root.join('public', 'images', 'abook-air.jpg'), 'r'),
               price:    1499.00

Product.create name:     'Goya',
                             category: Category.find_by_name('Laptops'),
                             brand:    Brand.find_by_name('Gazillion'),
                             image:    File.new(Rails.root.join('public', 'images', 'Goya.jpg'), 'r'),
                             price:    1499.00


# SMARTPHONES

aphone8 = Product.create name:     'Pre-Order aPhone 8',
                         category: Category.find_by_name('Smartphones'),
                         brand:    Brand.find_by_name('Apricot'),
                         image:    File.new(Rails.root.join('public', 'images', 'aPhone-8.png'), 'r'),
                         price:    100.00,
                         preorder: true
aphone8.features.build description: 'Voice Assistant Stoey'
aphone8.features.build description: 'Fireproof'
aphone8.features.build description: 'I10 Processor'
aphone8.color_options   = %w(White Black GREEN)
aphone8.storage_options = [16, 32, 64]
aphone8.save

sphone8 = Product.create name:     'sPhone 8',
                         category: Category.find_by_name('Smartphones'),
                         brand:    Brand.find_by_name('Singsong'),
                         image:    File.new(Rails.root.join('public', 'images', 'sPhone8.jpg'), 'r'),
                         price:    799.00
sphone8.features.build description: 'Voice Assistant Boxy'
sphone8.features.build description: 'Fireproof'
sphone8.features.build description: 'S10 Processor'
sphone8.save

aphone7 = Product.create name:     'aPhone 7 GREEN',
                         category: Category.find_by_name('Smartphones'),
                         brand:    Brand.find_by_name('Apricot'),
                         image:    File.new(Rails.root.join('public', 'images', 'aPhone7GREEN.png'), 'r'),
                         price:    699.00
aphone7.features.build description: 'High Quality Camera'
aphone7.features.build description: 'Waterproof'
aphone7.features.build description: 'I9 Processor'
aphone7.save

# HEADPHONES

Product.create name:     'sPhone 7',
               category: Category.find_by_name('Smartphones'),
               brand:    Brand.find_by_name('Singsong'),
               image:    File.new(Rails.root.join('public', 'images', 'sphone-7.jpg'), 'r'),
               price:    799.00

Product.create name:     'aPad',
               category: Category.find_by_name('Tablets'),
               brand:    Brand.find_by_name('Apricot'),
               image:    File.new(Rails.root.join('public', 'images', 'apad.jpg'), 'r'),
               price:    999.00

Product.create! name:     'Seal Buds',
                category: Category.find_by_name('Headphones'),
                brand:    Brand.find_by_name('Singsong'),
                image:    File.new(Rails.root.join('public', 'images', 'seal-buds.jpg'), 'r'),
                price:    99.00

aheadphones = Product.create! name:     'Sounds by Sir Simon',
                              category: Category.find_by_name('Headphones'),
                              brand:    Brand.find_by_name('Apricot'),
                              image:    File.new(Rails.root.join('public', 'images', 'aHeadphones.jpg'), 'r'),
                              price:    299.00

Deal.create! product:     aphone8,
             description: 'Guaranteed availability on day of launch'

Deal.create! product:     aphone7,
             description: 'A portion of the proceeds from each phone is donated to help fight HIV/AIDS',
             image:       File.new(Rails.root.join('public', 'images', '512px-Red_Ribbon.png'), 'r')

Deal.create! product:         aheadphones,
             description:     'FREE headphones with purchase of Apricot Book',
             trigger_product: apricotbook,
             price:           0.00

Deal.create! product:     sphone8,
             description: "Singsong's sPhone8 carries <strong>Boxy</strong> - your travel companion<br> it can <strong>translate any foreign text</strong><br> with the <strong>aim of a camera</strong>",
             image:       File.new(Rails.root.join('public', 'images', 'translate.jpg'), 'r')

Deal.create! product:         aphone8,
             description:     'Good news Matt! We have a <strong>SPECIAL OFFER</strong> just for you:<br><br>We will <strong>waive the regular €100 deposit</strong> for the <strong>aPhone 8 Pre-Order!</strong><br><br>Order now, and <strong>get it on the day of launch, guaranteed!',
             special:         true,
             trigger_product: apricotbook,
             price:           0.00

CSV.foreach('db/seed_data/WEX_output.csv', headers: true) do |row|
  data               = row.to_hash
  data['frequency']  = data['frequency'].to_i
  data['aphone']     = data['aphone'].to_i
  data['sphone']     = data['sphone'].to_i
  data['product_id'] = data['aphone'] > data['sphone'] ? aphone7.id : sphone8.id
  TrendingTopic.create! data
end

customer_interest_ml = MachineLearningService.create name:     'Customer Interest',
                                                     hostname: ENV['HOSTNAME'],
                                                     username: ENV['USERNAME'],
                                                     password: ENV['PASSWORD']

if customer_interest_ml.hostname == 'ibm-watson-ml.mybluemix.net' and customer_interest_ml.deployments.find_by_guid(ENV['APHONE_DEPLOYMENT'])
  customer_interest_ml.deployments.find_by_guid(ENV['APHONE_DEPLOYMENT']).update product: aphone8
  customer_interest_ml.deployments.find_by_guid(ENV['SPHONE_DEPLOYMENT']).update product: sphone8
else
  customer_interest_ml.deployments.build product: aphone8,
                                         guid: ENV['APHONE_DEPLOYMENT']
  customer_interest_ml.deployments.build product: sphone8,
                                         guid: ENV['SPHONE_DEPLOYMENT']
end

customer_interest_ml.save