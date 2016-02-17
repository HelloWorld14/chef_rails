bash 'update and upgrade server' do
  user 'root'
  code <<-EOC
sudo add-apt-repository ppa:nginx/stable -y
sudo apt-get update -y
sudo apt-get install nginx -y
  EOC
end


bash 'install nginx-server' do
  user 'root'
  code <<-EOC
sudo apt-get install nginx -y
  EOC
end

bash 'restart nginx-server' do
  user 'root'
  code <<-EOC
sudo service nginx restart
  EOC
end

bash 'install redis server' do
  user 'root'
  code <<-EOC
sudo add-apt-repository ppa:chris-lea/redis-server -y
sudo apt-get update -y
sudo apt-get install redis-server -y
  EOC
end

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
