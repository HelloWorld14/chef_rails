#bash 'update and upgrade server' do
#  user 'root'
#  code <<-EOC
#sudo add-apt-repository ppa:nginx/stable -y
#sudo apt-get update -y
#sudo apt-get install nginx -y
#  EOC
#end

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
  action :nothing
end

apt_repository 'redis-server' do
  uri 'ppa:chris-lea/redis-server'
  distribution node['lsb']['codename']
end
package 'redis-server'

execute 'restart redis-server' do
  command 'sudo service redis-server restart'
  action :nothing
end

package 'monit'

execute 'alter role for application' do
  command <<-COMMAND
sudo -u postgres psql -c "CREATE ROLE #{node['application']['database_user']} WITH superuser"
sudo -u postgres psql -c "ALTER ROLE #{node['application']['database_user']} WITH password '#{node['application']['database_user_password']}'"
sudo -u postgres psql -c "ALTER ROLE #{node['application']['database_user']}t WITH login"
sudo -u postgres psql -c "CREATE DATABASE #{node['application']['database_name']}"
  COMMAND
end

template "/etc/monit/monitrc" do
  owner "root"
  mode "0700"
  source "monitrc.erb"
end

template "/etc/monit/conf.d/svcnet" do
  owner "root"
  mode "0700"
  source "monit.conf.erb"
end

execute 'restart monit' do
  command 'sudo service monit restart'
  action :nothing
end




#bash 'install nginx-server' do
#  user 'root'
#  code <<-EOC
#sudo apt-get install nginx -y
#  EOC
#end

#bash 'restart nginx-server' do
#  user 'root'
#  code <<-EOC
#sudo service nginx restart
#  EOC
#end



#bash 'install redis server' do
#  user 'root'
#  code <<-EOC
#sudo add-apt-repository ppa:chris-lea/redis-server -y
#sudo apt-get update -y
#sudo apt-get install redis-server -y
#  EOC
#end

bash 'restart redis server' do
  user 'root'
  code <<-EOC
sudo /etc/init.d/redis-server restart -y
  EOC
end

bash 'install imagemagick' do
  user 'root'
  code <<-EOC
sudo apt-get install ruby-dev zlib1g-dev liblzma-dev -y
sudo apt-get install libgmp-dev -y
sudo apt-get install imagemagick libmagickwand-dev -y
  EOC
end
