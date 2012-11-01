# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :wikipedia_post do
      association :wikipedia_article
      association :post
    end
end
