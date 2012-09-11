class PostsController < ApplicationController

  expose(:post) { Post.find_by_year_and_title params[:year], params[:title] }
  expose(:posts_list_year) { Post.list_year(params[:year]).order(:id) }
  expose(:posts_recent) { Post.recent() }
  expose(:post_tags) { 
    tags = TagsPost.where('post_id = ?', post.id).map {|tp| tp.tag}
    tags.sort { |a,b| a.text <=> b.text }
  }

  layout "default"

  class Streamer
    def initialize(file_path)
      @file_path = file_path
    end
    def each
      File.open(@file_path) do |file|
          b = file.read(1024)
          while !b.nil?
            yield b
            b = file.read(1024)
          end
        end
    end
  end

  def index
    render 'index'
  end

  def by_id
    a_post = Post.find(params[:id])
    if a_post
      redirect_to post_path(a_post.year, a_post.title,'')
    else
      redirect_to post_index
    end
  end

  def show
    # post = Post.find_by_year_and_title params[:year], params[:title]
    if post
      show_post
    else
      render :text => 'Post not found', :status => 404
    end
  end

  private

  def show_post
    file_path = post.resolve_path params[:file_path]
    if FileTest.file? file_path
      if File.extname(file_path) == '.html'
        post.check_file
        render :file => post.path[0..-6], :formats => [:html], :handlers => [:erb, :haml], :layout => "post"
      else
        render_file file_path
      end
    else
      render :text => "File #{file_path} not found", :status => 404
    end
  end

  def list_year
    render 'list_year'
  end

  Mime::Type.register "application/vnd.wolfram.cdf", :cdf

  def render_file(file_path)
    extname = File.extname(file_path)[1..-1]
    mime_type = Mime::Type.lookup_by_extension(extname)
    content_type = mime_type.to_s unless mime_type.nil?
    puts "render_file(#{file_path}, #{content_type})"
    self.response.headers['Content-Type'] = content_type
    self.response.headers['Content-Disposition'] = 'inline'
    self.response.headers['Last-Modified'] = Time.now.ctime.to_s
    self.response_body = Streamer.new(file_path)
  end

end
