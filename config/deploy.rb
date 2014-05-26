require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/rbenv'
require 'mina/puma'
require 'mina_sidekiq/tasks'

set :term_mode, :system
set :domain, 'localhost'
set :user, 'www-data'
set :deploy_to, '/var/www/riak'
set :repository, 'https://github.com/Rabsztok/riak-test-app.git'
set :branch, 'master'
set :shared_paths, ['config/database.yml', 'config/ripple.yml', 'config/initializers/carrierwave.rb', 'public/system'. 'public/uploads', 'log']

task :environment do
  invoke :'rbenv:load'
end

task :setup => :environment do
  queue! %[mkdir -p "#{deploy_to}/shared" "#{deploy_to}/shared/log" "#{deploy_to}/shared/config" "#{deploy_to}/shared/public"]
  queue! %[chmod -R g+rx,u+rwx "#{deploy_to}/shared"]

  queue! %[touch "#{deploy_to}/shared/config/database.yml"]
  queue  %[echo "-----> Be sure to edit 'shared/config/database.yml'."]

  queue! %[touch "#{deploy_to}/shared/config/ripple.yml"]
  queue  %[echo "-----> Be sure to edit 'shared/config/ripple.yml'."]

  queue! %[touch "#{deploy_to}/shared/config/initializers/carrierwave.yml"]
  queue  %[echo "-----> Be sure to edit 'shared/config/initializers/carrierwave.yml'."]

  queue! %[ln -s "/media/storage/system" "#{deploy_to}/shared/public/system"]
end

desc "Deploys the current version to the server."
task :deploy => :environment do
  deploy do
    invoke :'sidekiq:quiet'
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'

    to :launch do
      invoke :'puma:restart'
      invoke :'sidekiq:restart'
    end
  end
end
