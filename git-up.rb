#!/usr/bin/env ruby
require 'pp'
# no stdout buffering
STDOUT.sync = true

# checks for windows/unix for chaining commands
OS_COMMAND_CHAIN = RUBY_PLATFORM =~ /mswin|mingw|cygwin/ ? '&' : ';'

Dir.entries('.').select do |entry|
  next if %w(. .. ,,).include? entry
  next unless File.directory? File.join('.', entry)
  next unless File.directory? File.join('.', entry, '.git')
  full_path = "#{Dir.pwd}/#{entry}"
  git_dir = "--git-dir=#{full_path}/.git --work-tree=#{full_path}"
  puts "\nUPDATING '#{full_path}' \n\n"
  puts `git #{git_dir} clean -f #{OS_COMMAND_CHAIN} git #{git_dir} checkout . #{OS_COMMAND_CHAIN} git #{git_dir} pull --rebase`
end
