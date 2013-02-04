include_recipe "database::mysql"
include_recipe "mysql::server"

mysql_connection_info = {:host => "localhost", :username => 'root', :password => node['mysql']['server_root_password']}

node['mysql']['databases'].each do |db|
  mysql_database db do
    connection mysql_connection_info
    action :create
  end
  mysql_database_user db do
    connection mysql_connection_info
    password db
    database_name db
    host '%'
    # host '10.0.2.0/24'
    action :grant
  end
end

mysql_database_user 'root' do
  connection mysql_connection_info
  password node['mysql']['server_root_password']
  host '%'
  action :grant
end
