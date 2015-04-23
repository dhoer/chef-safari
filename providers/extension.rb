# rubocop:disable Metrics/AbcSize, Metrics/MethodLength
def whyrun_supported?
  true
end

def accessibility
  tccutil = '/usr/sbin/tccutil.py'

  remote_file tccutil do
    source node['safari']['tccutil']['url']
    checksum node['safari']['tccutil']['checksum']
    mode '0755'
  end

  # System Preferences > Security & Privacy > Privacy > Accessibility
  execute "sudo #{tccutil} -i com.apple.RemoteDesktopAgent"
  execute "sudo #{tccutil} -i com.apple.Safari"
  execute "sudo #{tccutil} -i /usr/libexec/sshd-keygen-wrapper"
  # execute "sudo #{tccutil} -d com.apple.ScriptEditor2"
  # execute "sudo #{tccutil} -d com.apple.systemuiserver"
end

def open_safari
  execute new_resource.safariextz do
    command <<EOF
osascript -e '
tell application "Finder" to open POSIX file "'"#{new_resource.safariextz}"'"
delay 10
'
EOF
  end
end

def install_extension
  execute new_resource.safariextz do
    command <<EOF
osascript -e '
tell application "System Events"
  tell process "Safari"
    set frontmost to true
      repeat until (exists window 1) and subrole of window 1 is "AXDialog" -- wait until the dialog is displayed.
        delay 1
      end repeat
    click button 1 of front window -- install
  end tell
end tell
'
EOF
  end
end

def close_safari
  execute new_resource.safariextz do
    command <<EOF
osascript -e '
tell application "System Events"
  if ((name of processes) contains "Safari") then
    tell application "Safari" to quit
  end if
end tell
'
EOF
  end
end

action :install do
  converge_by('safari_extension') do
    if platform_family?('mac_os_x')
      accessibility
      open_safari
      install_extension
      close_safari
    else
      log('Resource safari_extension is not supported on this platform.') { level :warn }
    end
  end
end
