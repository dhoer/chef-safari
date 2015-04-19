v = safari_version

log('safari version') { message v }  unless v.nil?

execute "echo #{v} > /tmp/safari_version.txt"
