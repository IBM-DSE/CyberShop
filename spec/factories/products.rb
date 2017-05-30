FactoryGirl.define do
  factory :product do
    name 'MyString'
    category
    image { fixture_file_upload(Rails.root.join('spec', 'images', 'smartphone.png'), 'image/png') }
  end
end
