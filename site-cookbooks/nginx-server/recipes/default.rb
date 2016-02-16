bash 'update and upgrade server' do
  user 'root'
  code <<-EOC
sudo apt-get update -y
sudo apt-get upgrade -y
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