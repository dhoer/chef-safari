remote_file "#{Chef::Config[:file_cache_path]}/SafariDriver.safariextz" do
  source node['safari_test']['safari_driver']['url']
end

password = node['safari_test']['user']
salt = OpenSSL::Random.random_bytes(32)
iterations = 25_000 # Any value above 20k should be fine.

shadow_hash = OpenSSL::PKCS5.pbkdf2_hmac(
  password,
  salt,
  iterations,
  128,
  OpenSSL::Digest::SHA512.new
).unpack('H*').first
salt_value = salt.unpack('H*').first

user node['safari_test']['user'] do
  home "/Users/#{node['safari_test']['user']}"
  password shadow_hash
  salt salt_value
  iterations iterations
  manage_home true
end

macosx_gui_login node['safari_test']['user'] do
  password node['safari_test']['user']
end

safari_extension 'SafariDriver Extension' do
  safariextz "#{Chef::Config[:file_cache_path]}/SafariDriver.safariextz"
end
