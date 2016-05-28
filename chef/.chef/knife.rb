#
ohai.disabled_plugins = [:Passwd]
chef_content_dir      = Dir.getwd
client_name           = 'default'
#
chef_config_dir       = "#{chef_content_dir}/.chef"
#
cache_path       "#{chef_config_dir}/cache"
chef_server_url  'http://localhost:8889'
client_key       "#{chef_config_dir}/#{client_name}.pem"
cookbook_path    "#{chef_content_dir}/cookbooks"
node_name        client_name
ssl_verify_mode  :verify_none
#
