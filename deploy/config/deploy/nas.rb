server "nas",
  roles: [:web, :app, :db],
  user: "vincent",
  port: 22

set :branch, "master"
set :deploy_to, "/home/media/www/fabrics"

namespace :phpfpm do
    desc "Restart PHP-FPM on remote server"
    task :restart do
        on release_roles(:all) do
            execute "sudo systemctl restart php7.2-fpm"
            execute "sudo systemctl restart nginx"
        end
    end

    after 'deploy:publishing', 'phpfpm:restart'
end
