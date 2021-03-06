require File.dirname(__FILE__) + '/../../spec_helper'

describe "Range#to_a" do
  it "converts self to an array" do
    (-5..5).to_a.should == [-5, -4, -3, -2, -1, 0, 1, 2, 3, 4, 5]
    ('A'..'D').to_a.should == ['A','B','C','D']
    ('A'...'D').to_a.should == ['A','B','C']    
    (0xfffd...0xffff).to_a.should == [0xfffd,0xfffe]
    lambda { (0.5..2.4).to_a }.should raise_error(TypeError)
  end

  ruby_version_is "1.9" do
    # This crashed on 1.9 prior to r24573
    it "works with Ranges of Symbols" do
      (:A..:z).to_a.size.should == 58
    end
  end
end