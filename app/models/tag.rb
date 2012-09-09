class Tag < ActiveRecord::Base

  MIN_FONT_SIZE = 10
  MAX_FONT_SIZE = 12

  attr_accessible :text, :posts_counter
  has_many :tags_posts
  has_many :posts, :through => :tags_postsA

  def self.find_or_create(term)
    tag = Tag.find_by_text(term.downcase)
    return tag if tag
    tag = Tag.new(:text => term.downcase)
    tag.save
    return tag
  end

  def self.max_tag_count
    Rails.cache.fetch('max_tag_count', :expires_in => 24.hours) do
      Tag.select('MAX(posts_counter) as max_counter').first.max_counter
    end
  end

  def tag_size
    return MIN_FONT_SIZE if posts_counter.nil? or posts_counter == 0
    max_counter = Tag.max_tag_count || 0
    return MIN_FONT_SIZE + (MAX_FONT_SIZE - MIN_FONT_SIZE) * (posts_counter + 1) / (max_counter + 1)
  end

end
