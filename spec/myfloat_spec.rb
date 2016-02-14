require 'MyFloat'

RSpec.describe MyFloat do

  describe "value" do
    it "should have a value of 0 by default" do
       f = MyFloat.new
       expect(f.value).to eq 0.0
    end
    it "should represent 0.15625 correctly" do
       f = MyFloat.new 0b00111110001000000000000000000000
       #                 SEEEEEEEEFFFFFFFFFFFFFFFFFFFFFFF
       expect(f.value).to eq 0.15625
    end
    it "should represent 1.0 correctly" do
       f = MyFloat.new 0b00111111100000000000000000000000
       #                 SEEEEEEEEFFFFFFFFFFFFFFFFFFFFFFF
       expect(f.value).to eq 1.0
    end
  end

end
