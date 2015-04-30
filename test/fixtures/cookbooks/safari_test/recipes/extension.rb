remote_file "#{Chef::Config[:file_cache_path]}/SafariDriver.safariextz" do
  source node['safari_test']['safari_driver']['url']
  checksum node['safari_test']['safari_driver']['checksum']
end

safari_extension "#{Chef::Config[:file_cache_path]}/SafariDriver.safariextz" do
  action :install
end
