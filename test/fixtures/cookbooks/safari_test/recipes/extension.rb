remote_file "#{Chef::Config[:file_cache_path]}/SafariDriver.safariextz" do
  source 'http://selenium-release.storage.googleapis.com/2.45/SafariDriver.safariextz'
end

safari_extension "#{Chef::Config[:file_cache_path]}/SafariDriver.safariextz" do
  action :install
end
