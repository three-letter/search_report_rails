# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :result_browse_log do
    visit_id "MyString"
    page 1
    position 1
    page_size 1
    result_position 1
    search_keyword "MyString"
    browser_type "MyString"
    domain_id 1
  end
end
