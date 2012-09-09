# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tag do
      sequence(:text) { |n| "tag#{n}" }
      posts_counter 0
    end
end
