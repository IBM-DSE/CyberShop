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

Product.create! name: 'aPhone 9',
                category: Category.find_by_name('Smartphones'),
                brand: Brand.find_by_name('Apricot'),
                image: File.new(Rails.root.join('public', 'aPhone9.png'), 'r')

Product.create! name: 'aPhone 10',
                category: Category.find_by_name('Smartphones'),
                brand: Brand.find_by_name('Apricot'),
                image: File.new(Rails.root.join('public', 'aPhone10.png'), 'r'),
                preorder: true

Product.create! name: 'FujiBook',
                category: Category.find_by_name('Laptops'),
                brand: Brand.find_by_name('Apricot'),
                image: File.new(Rails.root.join('public', 'FujiBook.jpg'), 'r')

Product.create! name: 'sPhone 8',
                category: Category.find_by_name('Smartphones'),
                brand: Brand.find_by_name('Singsong'),
                image: File.new(Rails.root.join('public', 'sPhone8.jpg'), 'r')