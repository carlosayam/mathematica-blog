# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tags_post do
      association :tag
      association :post
    end
end
