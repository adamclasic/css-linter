require_relative '../lib/buffer.rb'
require_relative '../lib/logic.rb'
require_relative './spec_helper.rb'

describe 'Logic' do
  include Logic

  let(:file_path) { 'style.css' }

  describe '#check_buffer' do
    it 'check if Buffer#file_name return an instance of StringScanner ' do
      content = Buffer.new(file_path)
      expect(content.read_file.first).to be_a(StringScanner)
    end
  end

  describe '#check_indentation_declaration' do
    it 'check if the indentation of declaration is 2 spaces' do
      content = Buffer.new(file_path)
      expect do
        check_indentation_declaration(content.read_file)
      end.to output("Error: line 2, Wrong Indentation, expected 2 spaces.\n").to_stdout
    end
  end

  describe '#check_indentation_selctor' do
    it 'check if the indentation of selector is 0 spaces' do
      content = Buffer.new(file_path)
      expect do
        check_indentation_selector(content.read_file)
      end.to output("Error: line 1, Wrong Indentation, expected 0 spaces.\n").to_stdout
    end
  end

  describe '#check_trailing_space' do
    it 'check if there is a trailing space' do
      content = Buffer.new(file_path)
      expect do
        trailing_space(content.read_file)
      end.to output("Error: line 4, Spacing, Trailing space detected.\n").to_stdout
    end
  end

  describe '#check_space_checker' do
    it 'check space according to the given charecter' do
      content = Buffer.new(file_path)
      expect do
        space_checker(content.read_file)
      end.to output("Error: line 3, Line Format, Expected one empty line after }\n").to_stdout
    end
  end
end
