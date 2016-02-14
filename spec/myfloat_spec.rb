require 'MyFloat'

RSpec.describe MyFloat do

  describe "value" do
    it "should have a value of 0 by default" do
       f = MyFloat.new
       expect(f.value).to eq 0
    end
  end

end
