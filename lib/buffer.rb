class Buffer

    def initialize(file_path)
        @file_path = file_path
    end

    def read_file
        content_arr = ''
        File.open(@file_path, 'r') { |line| content_arr = line.readlines.map(&:chomp) }
        content_arr
    end

end

code = Buffer.new('test.txt')
p code.read_file