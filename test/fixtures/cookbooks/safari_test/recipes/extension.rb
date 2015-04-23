# https://support.apple.com/en-us/HT201710
execute 'Activate Remote Desktop Sharing, enable access and grant full privileges for the users "vagrant", '\
'restart ARD Agent and Menu extra' do
  command <<EOF
sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart \
 -activate -configure -access -on -users vagrant -privs -all -restart -agent -menu
EOF
end

remote_file "#{Chef::Config[:file_cache_path]}/SafariDriver.safariextz" do
  source 'http://selenium-release.storage.googleapis.com/2.45/SafariDriver.safariextz'
end

safari_extension "#{Chef::Config[:file_cache_path]}/SafariDriver.safariextz" do
  action :install
end
