v = safari_version

if v.nil?
  log('')
else
  log(v)
  execute "echo #{v} > /tmp/safari_version.txt"
end
