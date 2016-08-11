#!/usr/bin/env ruby
require 'pp'
# no stdout buffering
STDOUT.sync = true

# checks for windows/unix for chaining commands
OS_COMMAND_CHAIN = RUBY_PLATFORM =~ /mswin|mingw|cygwin/ ? '&' : ';'
COMMIT_LOG       = 'cloc-db/commit-log.csv'.freeze

Dir.entries('.').select do |entry|
  next if %w(. .. ,,).include? entry
  next unless File.directory? File.join('.', entry)
  next unless File.directory? File.join('.', entry, '.git')
  full_path = "#{Dir.pwd}/#{entry}"
  git_dir = "--git-dir=#{full_path}/.git --work-tree=#{full_path}"
  puts "\nCollecting Data '#{full_path}' \n\n"
  #puts `git #{git_dir} clean -f #{OS_COMMAND_CHAIN} git #{git_dir} checkout ."`
  #git log --pretty=format:'"%an","%aD",' --shortstat --no-merges | paste - - - > test.csv
  #puts `git #{git_dir} log --pretty=format:'"%an","%aD","#{entry}",' --shortstat --no-merges | paste - - - >> #{COMMIT_LOG }`

  puts `git #{git_dir} log --pretty=format:'"%an","%aD","#{entry}",' --since=1.weeks --shortstat --no-merges | paste - - - >> #{COMMIT_LOG }`
end

