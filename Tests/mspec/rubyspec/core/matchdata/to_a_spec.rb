require File.dirname(__FILE__) + '/../../spec_helper'

describe "MatchData#to_a" do
  it "returns an array of matches" do
    /(.)(.)(\d+)(\d)/.match("THX1138.").to_a.should == ["HX1138", "H", "X", "113", "8"]
  end  
end
