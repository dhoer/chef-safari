def whyrun_supported?
  true
end

action :install do
  converge_by('safari_extension') do
    execute "sudo #{Chef::Config[:file_cache_path]}/tccutil.py -i /usr/bin/osascript"
    execute "sudo #{Chef::Config[:file_cache_path]}/tccutil.py -i /usr/bin/osascript"
    execute <<EOF
osascript -e 'tell application "Safari"
  activate
end tell'
EOF
    execute <<EOF
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
end
