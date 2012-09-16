require 'yaml'

namespace :blog do
  deploy_config = YAML.load File.new('/etc/mathematica-blog/config.yml')
  posts_folder = deploy_config['posts_folder']
  posts_repo = deploy_config['posts_repo']
  throw "posts_folder not configured" if posts_folder.nil?
  task :update do
    if !File.directory? posts_folder
      puts "#{posts_folder} created"
      Dir.mkdir(posts_folder)
    end
    cd posts_folder do
      unless system("git remote -v")
        system "git init"
      end
      unless `git remote -v`.index(posts_repo)
        system "git remote add origin #{posts_repo}"
      end
      system "git pull --force origin master"
    end
  end
end

