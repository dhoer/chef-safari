name 'safari'
maintainer 'Dennis Hoer'
maintainer_email 'dennis.hoer@gmail.com'
license 'MIT'
description 'Configures Safari browser'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '1.0.1'

supports 'mac_os_x', '>= 10.9'

source_url 'https://github.com/dhoer/chef-safari' if respond_to?(:source_url)
issues_url 'https://github.com/dhoer/chef-safari/issues' if respond_to?(:issues_url)
