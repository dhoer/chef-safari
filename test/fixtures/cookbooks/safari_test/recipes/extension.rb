remote_file "#{Chef::Config[:file_cache_path]}/SafariDriver.safariextz" do
  source node['safari_test']['safari_driver']['url']
end

macosx_gui_login node['safari_test']['user'] do
  password node['safari_test']['user']
end

privacy_services_manager 'grant safari access' do
  service 'accessibility'
  user node['safari_test']['user']
  applications ['com.apple.SystemUIServer','com.apple.Safari']
  action :add
end

safari_extension 'SafariDriver Extension' do
  safariextz "#{Chef::Config[:file_cache_path]}/SafariDriver.safariextz"
end
