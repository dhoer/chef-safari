remote_file "#{Chef::Config[:file_cache_path]}/SafariDriver.safariextz" do
  source node['safari_test']['safari_driver']['url']
end

# privacy_services_manager 'allow remote login' do
#   service 'accessibility'
#   user node['safari_test']['user']
#   applications %w(
#     /System/Library/CoreServices/RemoteManagement/ARDAgent.app
#     /System/Library/CoreServices/SystemUIServer.app
#   )
#   admin true
# end

privacy_services_manager 'allow remote execution of applescript' do
  service 'accessibility'
  user node['safari_test']['user']
  applications %w(
    com.apple.Terminal
    com.apple.ScriptEditor2
    com.apple.Safari
  )
end

privacy_services_manager 'allow remote execution of applescript' do
  service 'accessibility'
  user node['safari_test']['user']
  applications %w(
    com.apple.Terminal
    com.apple.ScriptEditor2
    com.apple.Safari
    /usr/bin/osascript
    com.apple.Finder
  )
  admin true
end

# /usr/bin/security
# /usr/bin/osascript
# /usr/libexec/sshd-keygen-wrapper
# com.apple.ScriptEditor2
# com.apple.Safari
# com.apple.Finder
# com.apple.RemoteDesktopAgent
# com.apple.systempreferences
# com.apple.preference.security

macosx_gui_login node['safari_test']['user'] do
  password node['safari_test']['user']
  sensitive false
end

safari_extension 'SafariDriver Extension' do
  safariextz "#{Chef::Config[:file_cache_path]}/SafariDriver.safariextz"
end
