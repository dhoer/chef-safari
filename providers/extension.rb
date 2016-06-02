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
            tell application "Finder" to open POSIX file "#{new_resource.safariextz}"
            delay 10
            tell application "System Events"
              tell application process "Safari"
                set frontmost to true
                click button 1 of sheet 1 of window 1
              end tell
            end tell
            tell application "Safari" to quit
          '
        EOF
      end
    else
      log('Resource safari_extension is not supported on this platform.') { level :warn }
    end
  end
end
