require 'chef/server_api'
ARGV << "/nodes"
Chef::Config.from_file('.chef/knife.rb')
api = Chef::ServerAPI.new
ARGV.each do |path|
  $stderr.puts(api.get(path))
end
