# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
AdminUser.create! email: 'admin@example.com', password: 'password', password_confirmation: 'password'

%w(Smartphones Laptops Desktops).each { |name| Category.create! name: name }
%w(Apricot Gazillion Singsong).each { |name| Brand.create! name: name }

Customer.create! name: 'John Smith'

Product.create! name: 'aPhone 7',
                category: Category.find_by_name('Smartphones'),
                brand: Brand.find_by_name('Apricot'),
                image: File.new(Rails.root.join('public', 'images', 'aPhone9.png'), 'r')

aPhone8 = Product.create! name: 'aPhone 8',
                category: Category.find_by_name('Smartphones'),
                brand: Brand.find_by_name('Apricot'),
                image: File.new(Rails.root.join('public', 'images', 'aPhone10-wide.jpg'), 'r'),
                preorder: true

honeycrisp = Product.create! name: 'Honeycrisp Pro',
                category: Category.find_by_name('Laptops'),
                brand: Brand.find_by_name('Apricot'),
                image: File.new(Rails.root.join('public', 'images', 'FujiBook.jpg'), 'r')

sPhone8 = Product.create! name: 'sPhone 8',
                category: Category.find_by_name('Smartphones'),
                brand: Brand.find_by_name('Singsong'),
                image: File.new(Rails.root.join('public', 'images', 'sPhone8.jpg'), 'r')

Deal.create! product: honeycrisp,
             description: 'Get a FREE set of headphones when you purchase Honeycrisp Pro by Apricot!'

Deal.create! product: aPhone8,
             description: 'Pre-Order the upcoming aPhone 8 for just €100!'

Deal.create! product: sPhone8,
             description: "Singsong's all-new sPhone8 has a voice assistant Boxy that can sing for you!"

Deal.create! product: aPhone8,
             description: 'Good news! Because you are a loyal customer of the Apricot line and are about to purchase the Honeycrisp Book, we offer to waive the regular €100 Pre-Order. Add it to your cart right now for free!',
             special: true,
             trigger_product: honeycrisp
