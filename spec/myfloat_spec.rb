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
    it "adding 1.0 to 1.0 should equal 2.0 " do
       one = MyFloat.new 0b00111111100000000000000000000000
       #                   SEEEEEEEEFFFFFFFFFFFFFFFFFFFFFFF
       two = one.add(one)
       expect(two.value).to eq 2.0
    end
    it "adding 1.0 to 0.15625 should equal 1.15625 " do
       one = MyFloat.new 0b00111111100000000000000000000000
       #                   SEEEEEEEEFFFFFFFFFFFFFFFFFFFFFFF
       f = MyFloat.new 0b00111110001000000000000000000000
       #                 SEEEEEEEEFFFFFFFFFFFFFFFFFFFFFFF
       fadd = one.add(f)
       expect(fadd.value).to eq 1.15625
    end
    it "adding 0.156250 to 1.0 should equal 1.15625 " do
       f = MyFloat.new 0b00111110001000000000000000000000
       #                 SEEEEEEEEFFFFFFFFFFFFFFFFFFFFFFF
       one = MyFloat.new 0b00111111100000000000000000000000
       #                   SEEEEEEEEFFFFFFFFFFFFFFFFFFFFFFF
       fadd = f.add(one)
       expect(fadd.value).to eq 1.15625
    end
    it "should represent -1.0 correctly" do
       f = MyFloat.new 0b10111111100000000000000000000000
       #                 SEEEEEEEEFFFFFFFFFFFFFFFFFFFFFFF
       expect(f.value).to eq -1.0
    end
    it "adding -1.0 to 2.0 should be 1.0" do
       negone = MyFloat.new 0b10111111100000000000000000000000
       #                      SEEEEEEEEFFFFFFFFFFFFFFFFFFFFFFF
       one = MyFloat.new 0b00111111100000000000000000000000
       #                   SEEEEEEEEFFFFFFFFFFFFFFFFFFFFFFF
       two = one.add(one) # Tested earlier
       one = negone.add(two)
       expect(one.value).to eq 1.0
    end
    it "adding 2.0 to -1.0 should be 1.0" do
       negone = MyFloat.new 0b10111111100000000000000000000000
       #                      SEEEEEEEEFFFFFFFFFFFFFFFFFFFFFFF
       one = MyFloat.new 0b00111111100000000000000000000000
       #                   SEEEEEEEEFFFFFFFFFFFFFFFFFFFFFFF
       two = one.add(one) # Tested earlier
       one = two.add(negone)
       expect(one.value).to eq 1.0
    end
    it "adding -1.0 to -1.0 should be -2.0" do
       negone = MyFloat.new 0b10111111100000000000000000000000
       #                      SEEEEEEEEFFFFFFFFFFFFFFFFFFFFFFF
       negtwo = negone.add(negone)
       expect(negtwo.value).to eq -2.0
    end
    it "adding -1.0 to 1.0 should be 0.0" do
       negone = MyFloat.new 0b10111111100000000000000000000000
       #                      SEEEEEEEEFFFFFFFFFFFFFFFFFFFFFFF
       one = MyFloat.new 0b00111111100000000000000000000000
       #                   SEEEEEEEEFFFFFFFFFFFFFFFFFFFFFFF
       zero = negone.add(one)
       expect(zero.value).to eq 0.0
    end
  end

end
