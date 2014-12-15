#!/usr/bin/env ruby

File.open('todo.txt', 'r') do |file|
  counter = 1
  file.readliens.each do |line|
    name, created, completed = line.chomp.split(/,/)
    printf("%3d -s %s\n", counter, name)
    printf("       Created    : %s\n", created)
    unless completed.nil?
      printf("       Created    : %s\n", created)
    end
    counter += 1
  end
end

