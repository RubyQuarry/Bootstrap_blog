# config valid only for Capistrano 3.1
lock '3.1.0'

set :application, 'app_name'
set :repo_url, 'git@github.com:RubyQuarry/Bootstrap_blog.git'

set :full_app_name, "#{fetch(:application)}_#{fetch(:stage)}"
set :rbenv_type, :system
set :rbenv_ruby, '2.1.1'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

# Default deploy_to directory is /var/www/my_app
# set :deploy_to, '/var/www/my_app'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
 set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
 set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
 set :keep_releases, 5

set(:config_files, %w(
  unicorn.rb 
  unicorn_init.sh
  nginx.conf 
  database.example.yml
  log_rotation
  ))

set(:executable_config_files, %w(
  unicorn_init.sh

  ))

set(:symlinks, [
{
source: "nginx.conf",
link: "/etc/nginx/sites-enabled/#{full_app_name}"
}, {
link: "/etc/init.d/unicorn_#{full_app_name}" },
  {
    source: "log_rotation",
link: "/etc/logrotate.d/#{full_app_name}" }, ])

namespace :deploy do

  before :deploy, "deploy:check_revision"

  before :deploy, "deploy:run_tests"

  after 'deploy:symlink:shared', 'deploy:compile_assets_locally'

  after :finishing, 'deploy:cleanup'

  before 'deploy:setup_config', 'nginx:remove_default_vhost'


after 'deploy:setup_config', 'nginx:reload'

 # Restart monit so it will pick up any monit configurations
 # we've added
 #after 'deploy:setup_config', 'monit:restart'

 # As of Capistrano 3.1, the `deploy:restart` task is not called
 # automatically.
 after 'deploy:publishing', 'deploy:restart'
  
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end
