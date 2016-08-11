#!/usr/bin/env ruby
require 'pp'
# no stdout buffering
STDOUT.sync = true


# checks for windows/unix for chaining commands
OS_COMMAND_CHAIN = RUBY_PLATFORM =~ /mswin|mingw|cygwin/ ? '&' : ';'
COMMIT_CSV_REPORT = 'cloc-db/git_commit.csv'.freeze

Dir.entries('.').select do |entry|
  next if %w(. .. ,,).include? entry
  next unless File.directory? File.join('.', entry)
  if File.directory? File.join('.', entry, '.git')
    puts "\nGenerating Commit Report For Repository '#{entry}' \n\n"
    puts `git log --pretty=format:'"%h","%an","%aD","%s",' --shortstat --no-merges | paste - - - >  #{COMMIT_CSV_REPORT}`
  end
end
