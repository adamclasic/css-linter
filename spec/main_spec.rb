
require_relative '../lib/buffer.rb'
require_relative '../lib/logic.rb'
require_relative './spec_helper.rb'
# require 'strscan'

describe "Logic" do
  include Logic

  let(:file_path) {'style.css'}

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


  
end