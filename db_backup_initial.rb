#!/usr/bin/env ruby

database = ARGV.shift
username = ARGV.shift
password = ARGV.shift
end_if_iter = ARGV.shift

if end_of_iter.nil?
   backup_file = config[:database] + '_' + Time.now.strftime('%Y%m%d')
else
   backup_file = config[:database] + '_' + end_of_iter
end

`mysqldump -u#{username} -p#{password} #{database} > #{backup_file}.sql`
`gzip #{backup_file}.sql`

