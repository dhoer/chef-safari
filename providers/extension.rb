def whyrun_supported?
  true
end

action :install do
  converge_by('safari_extension') do
    # TODO: add apple script to load safari extension
    # http://stackoverflow.com/questions/24614477/how-to-install-extension-in-safari-by-applescript
    # https://macmule.com/2014/10/15/deploying-installing-safari-extensions-on-safari-6-1-7-2/
    execute <<EOF
osascript -e
'tell application "Safari"
  activate
end tell'
EOF
    execute <<EOF
osascript -e
'ignoring application responses
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
