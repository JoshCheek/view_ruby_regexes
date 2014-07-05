#!/usr/bin/env ruby

uncompiled_regex = ARGV.first || "a|b|c"

require 'open3'
print_regex_filename = File.expand_path "../vendor/onig-5.9.5/print_regex", __FILE__
out, err, status = Open3.capture3(print_regex_filename, uncompiled_regex)
regex_tree = err.split(/=====  (?:BEGIN|END) JOSH SECTION =====/)[1].strip


puts regex_tree
