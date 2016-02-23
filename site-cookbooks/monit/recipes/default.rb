package 'monit'

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
  action :run
end