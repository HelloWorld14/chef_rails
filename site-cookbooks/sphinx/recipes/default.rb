apt_repository 'sphinx-search 2'  do
  uri 'ppa:builds/sphinxsearch-stable'
  distribution node['lsb']['codename']
end

package 'mysql-server'

bash 'install mysql2 gem dep' do
  code <<-CODE
    sudo apt-get install libmysql-ruby libmysqlclient-dev -y
    sudo apt-get install libmysqlclient-dev -y
  CODE
end

package 'sphinxsearch'


bash "assign-postgres-password" do
  user_name = node[:authorization][:sudo][:users][0]
  user "root"
  code <<-EOH
sudo -u postgres psql -c "alter role #{user_name} with superuser"
sudo -u postgres psql -c "alter role #{user_name} with login"
sudo -u postgres psql -c "alter role #{user_name} with password 'qwe12345'"
  EOH
  action :run
end