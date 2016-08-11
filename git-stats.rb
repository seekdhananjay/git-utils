#!/usr/bin/env ruby
require 'pp'
# no stdout buffering
STDOUT.sync = true

# checks for windows/unix for chaining commands
OS_COMMAND_CHAIN = RUBY_PLATFORM =~ /mswin|mingw|cygwin/ ? '&' : ';'
CLOC_SQL         = 'cloc-db/clks-cloc-stats.sql'.freeze

Dir.entries('.').select do |entry|
  next if %w(. .. ,,).include? entry
  next unless File.directory? File.join('.', entry)
  if File.directory? File.join('.', entry, '.git')
    puts "\nGenerating CLOC Report For Repository '#{entry}' \n\n"
    puts `cloc --sql 1 --sql-project #{entry} --sql-append  #{entry} >> #{CLOC_SQL}`
  end
end
