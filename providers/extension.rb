def whyrun_supported?
  true
end

use_inline_resources

action :install do
  converge_by("install safari_extension #{new_resource.safariextz}") do
    if platform_family?('mac_os_x')
      execute new_resource.safariextz do
        retries 10
        command <<-EOF
          osascript -e '
            tell application "System Events"
                activate
                if not (UI elements enabled) then set (UI elements enabled) to true
            end tell
            tell application "Finder" to open POSIX file "'"#{new_resource.safariextz}"'"
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
          '
        EOF
      end
    else
      log('Resource safari_extension is not supported on this platform.') { level :warn }
    end
  end
end


if enabledGUISCripting(true) then
  -- GUI Scripting statements go here
  display dialog "GUI Scripting is enabled"
else
  --non-GUI scripting statements go here
  display dialog "GUI Scripting is disabled"
end if

    on enabledGUISCripting(switch)
tell application "System Events"
activate
if not (UI elements enabled) then set (UI elements enabled) to true
return (UI elements enabled)
end tell
end enabledGUISCripting
