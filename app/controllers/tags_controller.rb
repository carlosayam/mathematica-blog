class TagsController < ApplicationController

  expose(:tags_alphabetical) { Tag.order(:text) }
  expose(:post_per_tag) { 
    tag = Tag.find_by_text(params[:text].downcase)
    return [] if tag.nil?
    TagsPost.where("tag_id = ?",tag.id).order('post_id DESC').map {|tp| tp.post}
  }

  layout "default"

  def index
    render 'index'
  end

  def show
    render 'show'
  end

end
