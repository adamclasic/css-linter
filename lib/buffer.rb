# rubocop: disable Lint/UselessAssignment
require 'strscan'
class Buffer
  def initialize(file_path)
    @file_path = file_path
  end

  def read_file
    content_arr = []
    File.open(@file_path, 'r') { |line| content_arr = line.readlines.map(&:chomp) }
    @content_arr = content_arr.map { |val| val = StringScanner.new(val) }
  end
  attr_reader :content_arr
end
# rubocop: enable Lint/UselessAssignment
