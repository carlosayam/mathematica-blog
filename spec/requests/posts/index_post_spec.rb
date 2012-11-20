require 'spec_helper'

describe "Post index" do

  let(:post) { FactoryGirl.create(:post) }

  before { post }

  it "displays post description" do
    visit post_index_path
    page.should have_content(post.title)
    page.should have_content(post.description)
  end

  it "shows reference image" do
    visit post_index_path
    page.source.should include("src='" + post.image + "'")
  end

end

