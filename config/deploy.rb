require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
# require 'mina/rbenv'  # for rbenv support. (http://rbenv.org)
require 'mina/rvm'    # for rvm support. (http://rvm.io)

# Basic settings:
#   domain       - The hostname to SSH to.
#   deploy_to    - Path to deploy into.
#   repository   - Git repo to clone from. (needed by mina/git)
#   branch       - Branch name to deploy. (needed by mina/git)

set :term_mode, :system
set :domain, 'merch-home-riak'
set :deploy_to, '/home/app'
set :repository, 'https://github.com/Rabsztok/riak-test-app.git'
set :branch, 'master'

set :shared_paths, ['config/database.yml', 'config/ripple.yml', 'public/system', 'log']

task :environment do
  invoke :'rvm:use[ruby-1.9.3-p392@default]'
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
    # Put things that will set up an empty directory into a fully set-up instance of your project.
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'

    to :launch do
      queue 'sudo /etc/init.d/apache2 restart'
    end
  end
end

# For help in making your deploy script, see the Mina documentation:
#
#  - http://nadarei.co/mina
#  - http://nadarei.co/mina/tasks
#  - http://nadarei.co/mina/settings
#  - http://nadarei.co/mina/helpers

