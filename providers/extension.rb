def whyrun_supported?
  true
end

action :install do
  converge_by('safari_extension') do
    if platform_family?('mac_os_x')
      tccutil = '/usr/sbin/tccutil.py'

      remote_file tccutil do
        source node['safari']['tccutil']['url']
        checksum node['safari']['tccutil']['checksum']
        mode '0755'
      end

      execute "sudo #{tccutil} -i com.apple.RemoteDesktopAgent"
      execute "sudo #{tccutil} -i com.apple.Safari"
      execute "sudo #{tccutil} -i /usr/libexec/sshd-keygen-wrapper"

      execute 'start safari' do
        command <<EOF
osascript -e 'tell application "Safari"
activate
end tell'
EOF
      end

      execute new_resource.safariextz do
        command <<EOF
osascript -e 'ignoring application responses
  tell application "Safari"
    open "'"#{new_resource.safariextz}"'"
    end tell
end ignoring
tell application "System Events"
  tell process "Safari"
    set frontmost to true
      repeat until (exists window 1) and subrole of window 1 is "AXDialog" -- wait until the dialog is displayed.
        delay 1
      end repeat
    click button 1 of front window -- install
  end tell
end tell'
EOF
      end
    else
      log('Resource safari_extension is not supported on this platform.') { level :warn }
    end
  end
end
