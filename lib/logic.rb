require 'strscan'
require_relative 'buffer.rb'

module Logic

  def check_indentation_declaration(content_arr)
    content_arr.each_with_index do |val, i|
      test = val.scan_until(/:/) 
      val.reset
      # p val.bol?
      if test && val.scan(/\s+/) != '  '
        err_printer(i+1, 1, nil)
      end
    end
  end

  def check_indentation_selector(content_arr)
    content_arr.each_with_index do |val, i|
      test = val.scan_until(/{/) 
      val.reset
      # p val.bol?
      if test && val.scan(/\s+/) != nil
        err_printer(i+1, 8, nil)
      end
    end
  end

  def trailing_space(content_arr)
    content_arr.each_with_index do |val, i|
      test = val.string.split('')[-1]
      if test == ' '
        err_printer(i+1, 6, nil)
      end
    end
  end

  def check_space_after_char(val, i, char, type)
    if val.exist? /#{char}/
      val.reset
      val.skip_until(/#{char}/)
      test = val.scan(/\s+/)
      if test != ' '
        err_printer(i+1, type, char[-1])
      end
    end
  end

  def check_space_befor_char(val, i, char, type)
    if val.exist? /#{char}/
      val.reset
      test = val.scan_until(/#{char}/)
      test = test.split('').reverse.join('')
      test = StringScanner.new(test)
      test.scan /./
      test = test.scan(/\s+/)
      if test != ' '
        err_printer(i+1, type, char[-1])
      end
    end
  end

  # not tested

  def check_ifno_space_after_char(val, i, char, type)
    if val.exist? /#{char}/
      val.reset
      val.skip_until(/#{char}/)
      test = val.scan(/\s+/)
      if test == ' '
        err_printer(i+1, type, char[-1])
      end
    end
  end

  def check_ifno_space_befor_char(val, i, char, type)
    if val.exist? /#{char}/
      val.reset
      test = val.scan_until(/#{char}/)
      test = test.split('')[-2]
      if test == ' '
        err_printer(i+1, type, char[-1])
      end
    end
  end

  def check_newline_after_char(val, i, char, type)
    val.reset
    if val.exist?(Regexp.new(char))
      val.skip_until(Regexp.new(char))
      unless val.eos?
        err_printer(i+1, type, char[-1])
      end
    end
  end


  def space_checker(content_arr)
    content_arr.each_with_index do |val, i|
      check_space_after_char(val, i, '\:', 2)
      check_space_befor_char(val, i, '\{', 3)
      check_ifno_space_befor_char(val, i, '\;', 7)
      check_ifno_space_befor_char(val, i, '\;', 7)
      check_ifno_space_befor_char(val, i, '\}', 7)
      check_newline_after_char(val, i, '{', 4)
      check_newline_after_char(val, i, '}', 4)
      check_newline_after_char(val, i, ';', 4)
    end
  end
  
  def check_blanc_line(content_arr)
    content_arr_s = []
    content_arr.each { |val| content_arr_s << val.string }
    content_arr_s.each_with_index { |val, i|
      if content_arr_s[i].split('').include?('}') && content_arr_s[i+1] != ''
        err_printer(i, 5, '}')
      end
    }
  end


  def err_printer(line, type, char)
    case type
    when 1
      puts "Error: line #{line}, Wrong Indentation, expected 2 spaces."
    when 8
      puts "Error: line #{line}, Wrong Indentation, expected 0 spaces."
    when 2
      puts "Error: line #{line}, Spacing, expected single space after #{char}"
    when 3
      puts "Error: line #{line}, Spacing, expected single space before #{char}"
    when 4
      puts "Error: line #{line}, Line Format, Expected line break after #{char}"
    when 5
      puts "Error: line #{line}, Line Format, Expected one empty line after #{char}"
    when 6
      puts "Error: line #{line}, Spacing, Trailing space detected."
    when 7
      puts "Error: line #{line}, Spacing, unexpected space before #{char}"
    end
  end
end

# include Logic
# file = Buffer.new('./style.css')
# trailing_space(file.read_file)

# trailing_space([StringScanner.new('background-color: red;'), StringScanner.new('    background-color: red;'), StringScanner.new('p {'), StringScanner.new('p { ')])
# check_indentation_selector([StringScanner.new('background-color: red;'), StringScanner.new('    background-color: red;'), StringScanner.new('  p {'), StringScanner.new('p { ')])
# check_indentation_declaration([StringScanner.new('background-color: red;'), StringScanner.new('    background-color: red;'), StringScanner.new('p {'), StringScanner.new('p { ')])
# p 'time'
# space_checker([StringScanner.new('body { }'), StringScanner.new('  background-color: green; 1'), StringScanner.new('}')])
# p '2 time'
# check_blanc_line([StringScanner.new('body {'), StringScanner.new('  background-color: green;'), StringScanner.new('}'), StringScanner.new('')])
