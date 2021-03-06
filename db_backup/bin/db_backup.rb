#!/usr/bin/env ruby

require 'optparse'
require 'English'
require 'open3'

options = {
  gzip: true
}

option_parser = OptionParser.new do |opts|
  executable_name = File.basename($PROGRAM_NAME)
  opts.banner = "Backup one or more MySQL databases

Usage: #{executable_name} [options] database_name

"

  opts.on('-i', '--end-of-iteration',
         'Indicate that this backup is an "iteration" backup') do
    options[:iteration] = true
  end

  opts.on('-u USER', "--username",
          'Database username, in first.last format',
          /^.+\..+$/) do |user|
    options[:user] = user
  end

  opts.on('-p PASSWORD', "--password",
         'Database password') do |password|
    options[:password] = password
  end

  opts.on("--no-gzip", "Do not compress the backup file") do
    options[:gzip] = false
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

exit_status = 0
begin
  option_parser.parse!
  if ARGV.empty?
    puts "error: you must supply a database_name"
    puts
    puts option_parser.help
    exit_status |= 0b0010
  end
rescue OptionParser::InvalidArgument => ex
  puts ex.message
  puts option_parser
  exit_status |= 0b0001
end
exit exit_status unless exit_status == 0

database = ARGV.shift
username = options[:user]
password = options[:password]
end_if_iter = !!options[:iteration]

if end_if_iter.nil?
  backup_file = database + '_' + Time.now.strftime('%Y%m%d')
else
  backup_file = database + '_' + end_if_iter.to_s
end

# Signal.#trapはここに書いたからといって実行されるわけではない。
# 登録するだけなので、問題なし
Signal.trap("SIGINT") do
  FileUtils.rm "#{backup_file}.sql"
  exit 1
end

auth = ""
auth += " -u#{username}" if username
auth += " -p#{password}" if password

command = "mysqldump #{auth} #{database} > #{backup_file}.sql && gzip #{backup_file}.sql"
puts "Running '#{command}'"
stdout_str, stderr_str, status = Open3.capture3(command)

unless status.exitstatus == 0
  puts "There was a problem running '#{command}'"
  puts stderr_str
  exit 1
end

