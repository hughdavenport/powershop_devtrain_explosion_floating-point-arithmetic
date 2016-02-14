require 'MyFloat'

RSpec.describe MyFloat do

  describe "value" do
    it "should have a value of 0 by default" do
       f = MyFloat.new
       expect(f.value).to eq 0
    end
    it "should allow passing an integer constructor" do
       f = MyFloat.new 1
       expect(f.value).to eq 1
    end
    it "should represent 0.15625 correctly" do
       f = MyFloat.new 0b00111110001000000000000000000000
       expect(f.value).to eq 0.15625
    end
  end

end
