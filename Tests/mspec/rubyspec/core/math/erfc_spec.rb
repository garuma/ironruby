require File.dirname(__FILE__) + '/../../spec_helper'
require File.dirname(__FILE__) + '/fixtures/classes'

# erfc is the complementary error function  
describe "Math.erfc" do
  it "returns a float" do
    Math.erf(1).class.should == Float
  end
  
  it "returns the complimentary error function of the argument" do
    Math.erfc(0).should be_close(1.0, TOLERANCE)
    Math.erfc(1).should be_close(0.157299207050285, TOLERANCE)
    Math.erfc(-1).should be_close(1.84270079294971, TOLERANCE)
    Math.erfc(0.5).should be_close(0.479500122186953, TOLERANCE)
    Math.erfc(-0.5).should be_close(1.52049987781305, TOLERANCE)
    Math.erfc(10000).should be_close(0.0, TOLERANCE)
    Math.erfc(-10000).should be_close(2.0, TOLERANCE)
    Math.erfc(0.00000000000001).should be_close(0.999999999999989, TOLERANCE)
    Math.erfc(-0.00000000000001).should be_close(1.00000000000001, TOLERANCE) 
  end  
  
  ruby_version_is ""..."1.9" do
    it "raises an ArgumentError if the argument cannot be coerced with Float()" do    
      lambda { Math.erfc("test") }.should raise_error(ArgumentError)
    end
  end
  
  ruby_version_is "1.9" do
    it "raises a TypeError if the argument cannot be coerced with Float()" do    
      lambda { Math.erfc("test") }.should raise_error(TypeError)
    end
  end

  it "raises a TypeError if the argument is nil" do
    lambda { Math.erfc(nil) }.should raise_error(TypeError)
  end 
  
  it "accepts any argument that can be coerced with Float()" do
    Math.erfc(MathSpecs::Float.new).should be_close(0.157299207050285, TOLERANCE)
  end
end

describe "Math#erfc" do
  it "is accessible as a private instance method" do
    IncludesMath.new.send(:erf, 3.1415).should be_close(0.999991118444483, TOLERANCE)
  end
end
