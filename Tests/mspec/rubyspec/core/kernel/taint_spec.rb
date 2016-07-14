require File.dirname(__FILE__) + '/../../spec_helper'
require File.dirname(__FILE__) + '/fixtures/classes'

describe "Kernel#taint" do
  it "sets self to be tainted" do
    mock('tainted?').taint.tainted?.should == true
  end

  it "returns the immediate when called on an immediate" do
    imediate_values = [nil, true, false, 1, :sym]
    imediate_values.each{ |v| v.taint.should == v }
  end

  it "has no effect on immediate values" do
    imediate_values = [nil, true, false, 1, :sym]
    imediate_values.each{ |v| v.taint; v.tainted?.should be_false}
  end
end
