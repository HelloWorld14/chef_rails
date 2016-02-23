apt_repository 'nginx-server'  do
  uri 'ppa:nginx/stable'
  distribution node['lsb']['codename']
end
package 'nginx'

template "/etc/nginx/nginx.conf" do
  owner "root"
  mode "0644"
  source "nginx.conf.erb"
end

execute 'restart nginx-server' do
  command 'sudo service nginx restart'
  action :run
end

#execute 'alter role for application' do
#  command <<-COMMAND
#sudo -u postgres psql -c "CREATE ROLE #{node['application']['database_user']} WITH superuser"
#sudo -u postgres psql -c "ALTER ROLE #{node['application']['database_user']} WITH password '#{node['application']['database_user_password']}'"
#sudo -u postgres psql -c "ALTER ROLE #{node['application']['database_user']}t WITH login"
#sudo -u postgres psql -c "CREATE DATABASE #{node['application']['database_name']}"
#  COMMAND
#end



#bash 'install imagemagick' do
#  user 'root'
#  code <<-EOC
#sudo apt-get install ruby-dev zlib1g-dev liblzma-dev -y
#sudo apt-get install libgmp-dev -y
#sudo apt-get install imagemagick libmagickwand-dev -y
#  EOC
#end
