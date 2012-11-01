require 'spec_helper'

describe Post do

  let(:post) { FactoryGirl.create(:post) }
  let(:bad_post) { FactoryGirl.create(:post, :path => "#{Rails.application.config.posts_folder}/NOT_THERE") }

  it "checks file is up-to-date" do
    post.check_file().should be_true
  end

  it "checks file was removed" do
    bad_post.check_file().should be_false
  end

  it "resolves a relative path" do
    post.resolve_path("HTMLImage/test.png").match(/2012\/post001\/HTMLImage\/test.png$/).should be_true
  end

  it "resolves an empty path" do
    post.resolve_path(nil).match(/2012\/post001\/math001.html$/).should be_true
    post.resolve_path('').match(/2012\/post001\/math001.html$/).should be_true
  end

  it "has the tags" do
    post.tags.size.should == 3
    p = lambda {|tag| tag.text}
    post.tags.map(&p).should include('two words')   
  end

  it "has wikipedia references" do
    post.wikipedia_articles.size.should == 2
    p = lambda {|wa| wa.title}
    post.wikipedia_articles.map(&p).should include('M-Estimator')   
  end

end
