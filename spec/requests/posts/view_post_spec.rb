require 'spec_helper'

describe "Post" do

  let(:post) { FactoryGirl.create(:post) }

  it "displays" do
    visit post_path(post.year,post.title,'')
    page.should have_content(post.title)
  end

  it "shows images" do
    visit post_path(post.year,post.title,"HTMLFiles/math001_1.gif")
    page.status_code.should eq(200)
    page.response_headers["Content-Type"].should eq("image/gif")
    page.response_headers["Content-Length"].should eq(File.size("spec/sample_data/2012/post001/HTMLFiles/math001_1.gif").to_s)
  end

end

