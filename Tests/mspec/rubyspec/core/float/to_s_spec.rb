require File.dirname(__FILE__) + '/../../spec_helper'

describe "Float#to_s" do
  it "returns a string representation of self, possibly Nan, -Infinity, +Infinity" do
    0.551e7.to_s.should == "5510000.0"
    -3.14159.to_s.should == "-3.14159"
    0.0.to_s.should == "0.0"
    1000000000000.to_f.to_s.should == "1000000000000.0"
    10000000000000.to_f.to_s.should == "10000000000000.0"
    -10000000000000.to_f.to_s.should == "-10000000000000.0"
    (0.0 / 0.0).to_s.should == "NaN"
    (1.0 / 0.0).to_s.should == "Infinity"
    (-1.0 / 0.0).to_s.should == "-Infinity"
  end

  ruby_version_is "" ... "1.9" do
    platform_is_not :windows do
      it "returns a string representation of self (scientific notation)" do
        100000000000000.to_f.to_s.should == "1.0e+14"
        -100000000000000.to_f.to_s.should == "-1.0e+14"
        1.87687113714737e-40.to_s.should == "1.87687113714737e-40"
        1.50505000e-20.to_s.should == "1.50505e-20"
      end
    end

    platform_is :windows do 
      it "returns a string representation of self (scientific notation)" do
        100000000000000.to_f.to_s.should == "1.0e+014"
        -100000000000000.to_f.to_s.should == "-1.0e+014"
        1.87687113714737e-40.to_s.should == "1.87687113714737e-040"
        1.50505000e-20.to_s.should == "1.50505e-020"
      end
    end
  end

  ruby_version_is "1.9" do
    it "returns a string representation of self" do
      100000000000000.to_f.to_s.should == "100000000000000.0"
      -100000000000000.to_f.to_s.should == "-100000000000000.0"
    end
  end

  platform_is_not :openbsd do
    it "returns the correct values for -0.0" do
      -0.0.to_s.should == "-0.0"
    end
  end
end
