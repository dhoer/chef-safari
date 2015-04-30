# rubocop:disable Metrics/AbcSize, Metrics/MethodLength
def whyrun_supported?
  true
end

action :install do
  converge_by("install safari_extension #{new_resource.safariextz}") do
    if platform_family?('mac_os_x')
      execute new_resource.safariextz do
        command <<EOF
osascript -e '
tell application "Finder" to open POSIX file "'"#{new_resource.safariextz}"'"
delay 10
tell application "System Events"
  tell process "Safari"
    set frontmost to true
      repeat until (exists window 1) and subrole of window 1 is "AXDialog" -- wait until the dialog is displayed.
        delay 1
      end repeat
    click button 1 of front window -- install
  end tell
end tell
tell application "System Events"
  if ((name of processes) contains "Safari") then
    tell application "Safari" to quit
  end if
end tell
'
EOF
      end
    else
      log('Resource safari_extension is not supported on this platform.') { level :warn }
    end
  end
end
