remote_file "#{Chef::Config[:file_cache_path]}/SafariDriver.safariextz" do
  source node['safari_test']['safari_driver']['url']
  checksum node['safari_test']['safari_driver']['checksum']
end

macosx_gui_login 'vagrant' do
  password 'vagrant'
end

safari_extension 'SafariDriver Extension' do
  safariextz "#{Chef::Config[:file_cache_path]}/SafariDriver.safariextz"
end
