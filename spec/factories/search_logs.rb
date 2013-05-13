# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :search_log do
    visit_id "MyString"
    keyword "MyString"
    search_result_count 1
    browser_type "MyString"
    domain_id 1
  end
end
