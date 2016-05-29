def whyrun_supported?
  true
end

use_inline_resources

action :install do
  converge_by("install safari_extension #{new_resource.safariextz}") do
    if platform_family?('mac_os_x')

      ver = safari_version

      major_ver = ver.slice(0, ver.index('.'))

      # Safari 9+ prompts if you trust extension not from Safari Extensions Gallery
      trust_extension_script = <<-EOF
          osascript -e '
            tell application "Safari" to activate
            delay 2
            tell application "System Events"
              tell application process "Safari"
                set frontmost to true
                tell application "Safari" to open location "#{new_resource.safariextz}"
                delay 2
                click button 1 of sheet 1 of window 1
              end tell
            end tell
            tell application "Safari" to quit
          '
      EOF

      install_extension_script = <<-EOF
        osascript -e '
          tell application "Finder" to open POSIX file "#{new_resource.safariextz}"
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

      execute new_resource.safariextz do
        retries 10
        command major_ver == '9' ? trust_extension_script : install_extension_script
      end
    else
      log('Resource safari_extension is not supported on this platform.') { level :warn }
    end
  end
end

# execute new_resource.safariextz do
#   retries 10
#   command <<-EOF
#           osascript -e '
#             tell application "Finder" to open POSIX file "'"#{new_resource.safariextz}"'"
#             delay 10
#             tell application "System Events"
#               tell process "Safari"
#                 set frontmost to true
#                   repeat until (exists window 1) and subrole of window 1 is "AXDialog" -- wait for dialog
#                     delay 1
#                   end repeat
#                 click button 1 of front window -- install
#               end tell
#             end tell
#             if application "Safari" is running then quit application "Safari"
#           '
#   EOF
# end
#
