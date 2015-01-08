#!/usr/bin/env ruby

require 'optparse'

options = {}
option_parser = OptionParser.new do |opts|
  executable_name = File.basename($PROGRAM_NAME)
  opts.banner = "Backup one or more MySQL databases

Usage: #{executable_name} [options] database_name

"

  opts.on('-i', '--iteration',
         'Indicate that this backup is an "iteration" backup') do
    options[:iteration] = true
  end

  opts.on('-u USER',
          'Database username, in first.last format',
          /^.+\..+$/) do |user|
    options[:user] = user
  end

  opts.on('-p PASSWORD',
         'Database password') do |password|
    options[:password] = password
  end

  # serversのKeyに設定した値しか受け付けないようにする
  # --server devや--server qaなど。
  # 仮に、--server aaaと指定した場合は、
  # invalid argument: --server aaa (OptionParser::InvalidArgument)
  # となる。
  servers = { 'dev'  => '127.0.0.1',
              'qa'   => 'qa001.example.com',
              'prod' => 'www.example.com' }
  opts.on('--server SERVER', servers) do |address|
    options[:server] = address
  end
end

option_parser.parse!

# puts options.inspect  # For debug.

database = ARGV.shift
username = options[:user]
password = options[:password]
end_if_iter = !!options[:iteration]

if end_if_iter.nil?
  backup_file = database + '_' + Time.now.strftime('%Y%m%d')
else
  backup_file = database + '_' + end_if_iter.to_s
end

`mysqldump -u#{username} -p#{password} #{database} > #{backup_file}.sql`
`gzip #{backup_file}.sql`

