require 'bundler/capistrano'
$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
require 'rvm/capistrano'
require 'yaml'

deploy_config = YAML.load File.new('/etc/mathematica-blog/config.yml')

set :rvm_path, '/usr/local/rvm' 
set :rvm_bin_path, '/usr/local/rvm/bin'

set :default_environment, {
  'rvm_path' => '/usr/local/rvm',
  'rvm_bin_path' => '/usr/local/rvm/bin'
}

ssh_options[:forward_agent] = true
set :application, "mathematica-blog"
set :repository,  "git://github.com/carlosayam/mathematica-blog.git"

set :scm, :git
set :deploy_via, :remote_cache
set :deploy_to, deploy_config['deploy_to']

role :web, deploy_config['deploy_role']               # Your HTTP server, Apache/etc
role :app, deploy_config['deploy_role']               # This may be the same as your `Web` server
role :db,  deploy_config['deploy_role'], :primary => true # This is where Rails migrations will run

set :user, deploy_config['deploy_user']

set :use_sudo, false
set :keep_releases, 3

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
  task :seed do
    run "cd #{current_path}; rake db:seed RAILS_ENV=#{rails_env}"
  end
end

