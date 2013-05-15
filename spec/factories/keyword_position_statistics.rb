# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :keyword_position_statistic, :class => 'KeywordPositionStatistics' do
    search_keyword "MyString"
    position 1
    count 1
    domain_id 1
  end
end
