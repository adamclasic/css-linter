#!/usr/bin/env ruby

require_relative '../lib/buffer.rb'
require_relative '../lib/logic.rb'
include Logic

file_path = ARGF.argv[0]

if file_path

    file = Buffer.new(file_path)
    # File.open('style.css', 'r')
    # puts Dir.pwd
    # p file.read_file

    check_indentation_declaration(file.read_file)
    check_indentation_selector(file.read_file)
    trailing_space(file.read_file)
    space_checker(file.read_file)

else
    puts 'File name is required!'
end