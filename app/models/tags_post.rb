class TagsPost < ActiveRecord::Base
  attr_accessible :tag, :post
  belongs_to :tag
  belongs_to :post
end
