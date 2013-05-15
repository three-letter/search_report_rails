# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :search_statistic, :class => 'SearchStatistics' do
    count 1
    domain_id 1
  end
end
