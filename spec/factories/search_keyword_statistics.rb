# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :search_keyword_statistic, :class => 'SearchKeywordStatistics' do
    search_keyword "MyString"
    search_count 1
    domain_id 1
  end
end
