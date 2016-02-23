apt_repository 'redis-server' do
  uri 'ppa:chris-lea/redis-server'
  distribution node['lsb']['codename']
end

package 'redis-server'

execute 'restart redis-server' do
  command 'sudo service redis-server restart'
  action :nothing
end