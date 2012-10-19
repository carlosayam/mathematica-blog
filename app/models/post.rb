require 'find'
require 'yaml'

class Post < ActiveRecord::Base

  ENCODER = Encoding::Converter.new("US-ASCII","UTF-8", {:invalid => :replace, :undef => :replace })

  attr_accessible :year, :title, :path, :path_mtime, :description
  has_many :tags_posts
  has_many :tags, :through => :tags_posts

  scope :list_year, lambda { |year| where("year = ?",year) }
  scope :recent, order(:id).reverse_order.limit(5)

  def check_file
    return false unless FileTest.file?(path) && FileTest.file?(yml_path)
    return true if path_mtime == File.mtime(path)
    return refresh_record
  end

  def yml_path
    path + '.yml'
  end

  def self.years
    Rails.cache.fetch('posts_years', :expires_in => 24.hours) do
      Post.select(:year).order(:year).uniq
    end
  end

  def self.reload_year(year)
    year_dir = "#{Rails.application.config.posts_folder}/#{year}"
    return false unless File.directory? year_dir
    # set path_mtime to 0 for the year
    min_path_mtime = nil
    Find.find(year_dir) do |path|
       if File.extname(path) == '.yml'
          yaml = YAML.load File.new(path)
          html_file = File.join File.dirname(path), File.basename(path, '.yml')
          min_path_mtime ||= File.mtime(html_file).to_i if File.file? html_file
          a_post = Post.find_by_path(html_file)
          if a_post
            a_post.refresh_record
          else
            if FileTest.file? html_file
              Post.process_html html_file
              post = Post.new :year => year, :title => yaml['title'], :path => html_file, :path_mtime => File.mtime(html_file),
                :description => yaml['description']
              post.save
            end
          end
       end
       next
    end
    Post.where("year = ? AND path_mtime < ?", year, min_path_mtime).destroy_all 
    return true
  end

  def resolve_path(a_path)
    return path if !a_path || a_path.empty?
    return File.join(File.dirname(path),a_path)
  end

  def refresh_record
    yaml = YAML.load File.new(yml_path) 
    self.title = yaml['title']
    self.description = yaml['description']
    if yaml['tags']
      tag_list = yaml['tags'].map {|term| Tag.find_or_create(term)}
      TagsPost.find_all_by_post_id(self.id).each {|tp| tp.destroy }
      puts tag_list.each {|t| TagsPost.new(:tag => t, :post => self).save }
    end
    Post.process_html(path)
    self.path_mtime = File.mtime path
    self.save()
    return self.reload
  end

  def self.process_html(html_file)
    str = File.read(html_file)
    if str.include? '<body>'
      start_pos = 6 + str.index('<body>')
      end_pos = str.index('</body>')
      str.slice! 0, start_pos
      str.slice! end_pos-start_pos, str.size
      str = self.process_cdf(str)
      File.open(html_file,'w') do |f|
        f.write(ENCODER.convert(str))
      end
    end
  end

  def self.process_cdf(str)
    pattern = /<p class="Output">\s*<a id="(([^.]+)\.cdf)"><\/a>\s*<([^>]+)>\s*<\/p>/mi
    str.gsub(pattern) do |match|
      cdf_name = $1
      inner_html = $3
      wh = $3.match(/width="([0-9]+)" height="([0-9]+)"/) do
             "#{$1.to_i + 15}, #{$2.to_i + 14}"
        end
      replacement = <<-eos
         <script type="text/javascript">
         //<![CDATA[
         var cdf = cdfplugin();
         cdf.setDefaultContent('<p class="Output"><#{inner_html}><br/><small>Interactive content: needs free <a href="http://www.wolfram.com/cdf-player/">CDF player</a>.</small></p>');
         cdf.embed('#{cdf_name}', #{wh});
         //]]>
         </script>
      eos
      replacement 
      end
  end

end
