require 'strscan'
require_relative 'buffer.rb'
# rubocop: disable Metrics/ModuleLength, Style/GuardClause, Metrics/CyclomaticComplexity
module Logic
  def check_indentation_declaration(content_arr)
    content_arr.each_with_index do |val, iii|
      test = val.scan_until(/:/)
      val.reset
      err_printer(iii + 1, 1, nil) if test && val.scan(/\s+/) != '  '
    end
  end

  def check_indentation_selector(content_arr)
    content_arr.each_with_index do |val, iii|
      test = val.scan_until(/{/)
      val.reset
      err_printer(iii + 1, 8, nil) if test && !val.scan(/\s+/).nil?
    end
  end

  def trailing_space(content_arr)
    content_arr.each_with_index do |val, iii|
      test = val.string.split('')[-1]
      err_printer(iii + 1, 6, nil) if test == ' '
    end
  end

  def check_space_after_char(val, iii, char, type)
    if val.exist?(/#{char}/)
      val.reset
      val.skip_until(/#{char}/)
      test = val.scan(/\s+/)
      err_printer(iii + 1, type, char[-1]) if test != ' '
    end
  end

  def check_space_befor_char(val, iii, char, type)
    if val.exist?(/#{char}/)
      val.reset
      test = val.scan_until(/#{char}/)
      test = test.split('').reverse.join('')
      test = StringScanner.new(test)
      test.scan(/./)
      test = test.scan(/\s+/)
      err_printer(iii + 1, type, char[-1]) if test != ' '
    end
  end

  def check_ifno_space_after_char(val, iii, char, type)
    if val.exist?(/#{char}/)
      val.reset
      val.skip_until(/#{char}/)
      test = val.scan(/\s+/)
      err_printer(iii + 1, type, char[-1]) if test == ' '
    end
  end

  def check_ifno_space_befor_char(val, iii, char, type)
    if val.exist?(/#{char}/)
      val.reset
      test = val.scan_until(/#{char}/)
      test = test.split('')[-2]
      err_printer(iii + 1, type, char[-1]) if test == ' '
    end
  end

  def check_newline_after_char(val, iii, char, type)
    val.reset
    if val.exist?(Regexp.new(char))
      val.reset
      val.scan_until(Regexp.new(char))
      err_printer(iii + 1, type, char[-1]) unless val.eos?
    end
  end

  def space_checker(content_arr)
    content_arr.each_with_index do |val, iii|
      check_space_after_char(val, iii, '\:', 2)
      check_space_befor_char(val, iii, '\{', 3)
      check_ifno_space_befor_char(val, iii, '\;', 7)
      check_ifno_space_befor_char(val, iii, '\;', 7)
      check_ifno_space_befor_char(val, iii, '\}', 7)
      unless content_arr[iii + 1].nil?
        content_arr[iii + 1].reset
        content_arr[iii].reset
        err_printer(iii + 1, 5, '}') if content_arr[iii + 1].string != '' && content_arr[iii].exist?(/\}/)
      end
      check_newline_after_char(val, iii, '\}', 5)
      check_newline_after_char(val, iii, '\;', 5)
      check_newline_after_char(val, iii, '\{', 5)
    end
  end

  def check_blanc_line(content_arr)
    content_arr_s = []
    content_arr.each { |val| content_arr_s << val.string }
    content_arr_s.each_with_index do |_val, iii|
      err_printer(iii, 5, '}') if content_arr_s[iii].split('').include?('}') && content_arr_s[iii + 1] != ''
    end
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
# rubocop: enable Metrics/ModuleLength, Style/GuardClause, Metrics/CyclomaticComplexity
