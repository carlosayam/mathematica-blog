require 'yaml'

namespace :blog do
  deploy_config = YAML.load File.new('/etc/mathematica-blog/config.yml')
  task :update do
    system "ls -l #{deploy_config['posts_folder']}"
  end
end

