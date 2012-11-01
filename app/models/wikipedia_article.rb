class WikipediaArticle < ActiveRecord::Base

  MIN_FONT_SIZE = 10
  MAX_FONT_SIZE = 12

  attr_accessible :title

  def url
    "http://en.wikipedia.org/wiki/#{title.gsub(' ','_')}"
  end

  def self.find_or_create(title)
    wa = WikipediaArticle.find_by_title(title)
    return wa if wa
    wa = WikipediaArticle.new(:title => title)
    wa.save
    return wa
  end

end
