#!/usr/bin/env ruby

require_relative '../lib/buffer.rb'
require_relative '../lib/logic.rb'
# rubocop: disable Style/MixinUsage
include Logic

file_path = ARGF.argv[0]

if file_path
  file = Buffer.new(file_path)
  check_indentation_declaration(file.read_file)
  check_indentation_selector(file.read_file)
  trailing_space(file.read_file)
  space_checker(file.read_file)
else
  puts 'File name is required!'
end
# rubocop: enable Style/MixinUsage
