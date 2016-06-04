def whyrun_supported?
  true
end

use_inline_resources

action :install do
  converge_by("install safari_extension #{new_resource.safariextz}") do
    if platform_family?('mac_os_x')
      ver = safari_version
      major_ver = ver.slice(0, ver.index('.'))

      file "#{Chef::Config[:file_cache_path]}/open_safari.sh" do
        content <<EOF
#!/bin/bash
open #{new_resource.safariextz}
EOF
        mode '0777'
        # only_if { major_ver == '9' }
      end

      execute "#{Chef::Config[:file_cache_path]}/open_safari.sh" do
        # only_if { major_ver == '9' }
      end

      file "#{Chef::Config[:file_cache_path]}/safari_extension.sh" do
        content <<EOF
#!/usr/bin/env /usr/bin/osascript
# tell application "Finder" to open POSIX file "#{new_resource.safariextz}"
delay 10
tell application "System Events"
  tell application process "Safari"
    set frontmost to true
    click button 1 of sheet 1 of window 1
  end tell
end tell
tell application "Safari" to quit
EOF
        mode '0777'
        only_if { major_ver == '9' }
      end

      file "#{Chef::Config[:file_cache_path]}/safari_extension.sh" do
        content <<EOF
#!/usr/bin/env /usr/bin/osascript
#tell application "Finder" to open POSIX file "#{new_resource.safariextz}"
delay 10
tell application "System Events"
  tell process "Safari"
    set frontmost to true
      repeat until (exists window 1) and subrole of window 1 is "AXDialog" -- wait for dialog
        delay 1
      end repeat
    click button 1 of front window -- install
  end tell
end tell
if application "Safari" is running then quit application "Safari"
EOF
        mode '0777'
        not_if { major_ver == '9' }
      end

      privacy_services_manager 'trust safari extension' do
        service 'accessibility'
        user node['safari_test']['user']
        applications ["#{Chef::Config[:file_cache_path]}/safari_extension.sh"]
      end

      execute "#{Chef::Config[:file_cache_path]}/safari_extension.sh"
    else
      log('Resource safari_extension is not supported on this platform.') { level :warn }
    end
  end
end
