# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  file_path =  "#{Rails.application.config.posts_folder}/2012/post001/math001.html"
  factory :post do
      title "Example post"
      year 2012
      path file_path
      path_mtime File.mtime(file_path)
      after(:create) do |post, evaluator|
        ['example', 'rspec', 'two words'].each do |s|
          FactoryGirl.create(:tags_post, :tag => FactoryGirl.create(:tag, :text => s), :post => post)  
        end
        ['M-Estimator', 'Haar measure'].each do |s|
          FactoryGirl.create(:wikipedia_post, :wikipedia_article => FactoryGirl.create(:wikipedia_article, :title => s), :post => post)  
        end
      end
    end
end
