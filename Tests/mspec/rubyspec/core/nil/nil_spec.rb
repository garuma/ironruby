require File.dirname(__FILE__) + '/../../spec_helper'

describe "NilClass#nil?" do
  it "returns true" do
    nil.nil?.should == true
  end
end
