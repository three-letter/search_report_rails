# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :domain do
    name { "domain_#{Domain.count + 1}" } 
  end
end
