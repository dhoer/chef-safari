remote_file "#{Chef::Config[:file_cache_path]}/SafariDriver.safariextz" do
  source node['safari_test']['safari_driver']['url']
end

privacy_services_manager 'allow remote login' do
  service 'accessibility'
  user node['safari_test']['user']
  applications %w(
    /System/Library/CoreServices/RemoteManagement/ARDAgent.app
    /System/Library/CoreServices/SystemUIServer.app
    /usr/bin/security
    /usr/bin/osascript
    /usr/libexec/sshd-keygen-wrapper
    com.apple.Finder
    com.apple.LockScreen
    com.apple.RemoteDesktopAgent
    com.apple.Safari
    com.apple.ScriptEditor2
    com.apple.systemevents
    com.apple.Terminal
    com.apple.iTerm
  )
  admin true
end

macosx_gui_login node['safari_test']['user'] do
  password node['safari_test']['user']
  sensitive false
end

safari_extension 'SafariDriver Extension' do
  safariextz "#{Chef::Config[:file_cache_path]}/SafariDriver.safariextz"
end
