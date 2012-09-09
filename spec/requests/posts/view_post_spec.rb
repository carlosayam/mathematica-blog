require 'spec_helper'

describe "Post" do

  let(:post) { FactoryGirl.create(:post) }

  it "displays" do
    visit post_path(post.year,post.title)
    page.should have_content(post.title)
  end

  pending "shows images" do
    visit post_path(post.year,post.title,"images/img001.png")
    page.should have_mime("image/png")
    page.should have_size(file_size("#{examples}/example post/images/img001.png"))
  end

end

