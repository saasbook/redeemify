require 'spec_helper'

describe CodeGenerator do
  describe 'basic operation' do
    before :each do
      @seq = 27403092740035
      @cg = CodeGenerator.new(@seq)
      end
    it 'is invertible' do
      code = @cg.generate
      expect(@cg.decipher(code)).to eq(@seq)
    end
  end
end
