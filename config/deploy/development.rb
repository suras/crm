require "rvm/capistrano"
require "bundler/capistrano"

server "96.126.122.163", :app, :web, :db, :primary => true
set :deploy_to, "/var/www/hootquest/"
set :branch, 'master'
set :scm_verbose, true
set :use_sudo, false
set :rails_env, "development" #added for delayed job 
set :rvm_type, :system


after 'deploy:update_code' do
  # run "cd #{release_path}; RAILS_ENV=production rake assets:precompile"
  run "cd #{release_path};"
  run "mkdir -p #{release_path}/tmp/cache;"
  run "chmod -R 777 #{release_path}/tmp/cache;"
  run "mkdir -p #{release_path}/public/uploads;"
  run "chmod -R 777 #{release_path}/public/uploads"
  run "rm -rf #{release_path}/public/system"
  # run "unlink #{release_path}/public/db_admin"
  # run "unlink #{release_path}/public/blog"

  run "ln -s #{shared_path}/system/ #{release_path}/public/" 
  run "ln -s '/var/www/blog' #{release_path}/public/" 
  run "ln -s '/var/www/db_admin' #{release_path}/public/"

  run "cd #{release_path} && bundle --deployment"
  run "cd #{release_path} && rake db:create"
  run "cd #{release_path} && rake db:migrate"
  # run "cd #{release_path} && RAILS_ENV=production rake assets:precompile"
  # run "chown -R www-data:www-data #{release_path}/*"
  # run "chmod -R 777 #{release_path}/log"
end

namespace :deploy do
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end