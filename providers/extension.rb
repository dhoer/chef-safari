def whyrun_supported?
  true
end

use_inline_resources

action :install do
  converge_by("install safari_extension #{new_resource.safariextz}") do
    if platform_family?('mac_os_x')
      execute 'security unlock-keychain -p travis ~/Library/Keychains/login.keychain'

      execute new_resource.safariextz do
        retries 3
        command <<-EOF
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
      end
    else
      log('Resource safari_extension is not supported on this platform.') { level :warn }
    end
  end
end
