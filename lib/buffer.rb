# rubocop: disable Lint/UselessAssignment
require 'strscan'
class Buffer
  attr_reader :content_arr
  def initialize(file_path)
    @file_path = file_path
    @content_arr = []
  end

  def read_file
    content_arr = []
    File.open(@file_path, 'r') { |line| content_arr = line.readlines.map(&:chomp) }
    @content_arr = content_arr.map { |val| val = StringScanner.new(val) }
  end
end
# rubocop: enable Lint/UselessAssignment
