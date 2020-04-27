require 'strscan'

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
      if test && val.scan(/\s+/) != ''
        err_printer(i+1, 1, nil)
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

  def check_space_after_char(val, i, char)
    
    if val.exist? /#{char}/
      val.reset
      val.skip_until(/#{char}/)
      test = val.scan(/\s+/)
      if test != ' '
        err_printer(i+1, 2, ':')
      end
    end
    
  end

  def check_space_befor_char(val, i, char)
    if val.exist? /#{char}/
      val.reset
      test = val.scan_until(/#{char}/)
      test = test.split('')[-1]
      if test != ' '
        err_printer(i+1, 3, '{')
      end
    end

  end

  def space_checker(content_arr)
    content_arr.each_with_index do |val, i|

      check_space_after_char(val, i, '\:')
      check_space_befor_char(val, i, '\{')
    end

  end
    

  def err_printer(line, type, char)

    case type
    when 1
      puts "Error: line #{line}, Wrong Indentation, expected 2 spaces."
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
    end

  end


end

include Logic

trailing_space([StringScanner.new('background-color: red;'), StringScanner.new('    background-color: red;'), StringScanner.new('p {'), StringScanner.new('p { ')])
check_indentation_selector([StringScanner.new('background-color: red;'), StringScanner.new('    background-color: red;'), StringScanner.new('p {'), StringScanner.new('p { ')])
check_indentation_declaration([StringScanner.new('background-color: red;'), StringScanner.new('    background-color: red;'), StringScanner.new('p {'), StringScanner.new('p { ')])
p 'time'
space_checker([StringScanner.new('background-color: red;'), StringScanner.new('p{'), StringScanner.new('color:red;')])