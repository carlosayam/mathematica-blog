class WikipediaPost < ActiveRecord::Base
  attr_accessible :wikipedia_article, :post
  belongs_to :wikipedia_article
  belongs_to :post
end
