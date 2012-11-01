# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :wikipedia_article do
      sequence(:title) { |n| "Article #{n}" }
    end
end
