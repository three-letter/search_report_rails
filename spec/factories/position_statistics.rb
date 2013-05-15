# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :position_statistic, :class => 'PositionStatistics' do
    position 1
    count 1
    domain_id 1
  end
end
