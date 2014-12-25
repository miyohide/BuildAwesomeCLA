#!/usr/bin/env ruby

require 'optparse'

options = {}
option_parser = OptionParser.new do |opts|
  opts.on("-i", "--iteration") do
    options[:iteration] = true
  end

  opts.on("-u USER") do |user|
    unless user =~ /^.+\..+$/
      raise ArgumentError, "USER must be in 'first.last' format"
    end
    options[:user] = user
  end

  opts.on("-p PASSWORD") do |password|
    options[:password] = password
  end
end

option_parser.parse!
database = ARGV.shift
username = options[:user]
password = options[:password]
end_if_iter = !!options[:iteration]

if end_of_iter.nil?
  backup_file = config[:database] + '_' + Time.now.strftime('%Y%m%d')
else
  backup_file = config[:database] + '_' + end_of_iter
end

`mysqldump -u#{username} -p#{password} #{database} > #{backup_file}.sql`
`gzip #{backup_file}.sql`

