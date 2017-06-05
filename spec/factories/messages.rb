FactoryGirl.define do
  factory :message do
    content "MyString"
    watson_response false
    customer nil
  end
end
