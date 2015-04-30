if platform_family?('mac_os_x')
  # https://support.apple.com/en-us/HT201710
  execute 'activate remote desktop sharing for vagrant' do
    command <<EOF
sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart \
 -activate -configure -access -on -users vagrant -privs -all -restart -agent -menu
EOF
  end

  execute 'switch to login window' do
    command <<EOF
sudo "/System/Library/CoreServices/Menu Extras/User.menu/Contents/Resources/CGSession" -suspend
EOF
  end

  execute 'login to gui' do
    command <<EOF
osascript -l JavaScript -e "
var se = Application('System Events')
se.keystroke('vagrant')
se.keystroke.return
delay(3)
se.keystroke('vagrant')
se.keystroke.return
delay(3)
se.keystroke.tab
se.keystroke.return
se.keystroke.return
"
EOF
  end

  execute 'wait for login to build remote desktop agent' do
    command 'sleep 30'
    not_if { ::File.exist?('/Library/Application Support/com.apple.TCC/TCC.db') }
  end

  macosx_accessibility ['com.apple.RemoteDesktopAgent', '/usr/libexec/sshd-keygen-wrapper']
end
