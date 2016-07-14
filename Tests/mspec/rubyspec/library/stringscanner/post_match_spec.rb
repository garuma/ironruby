require File.dirname(__FILE__) + '/../../spec_helper'
require 'strscan'

describe "StringScanner#post_match" do
  before :each do
    @s = StringScanner.new("This is a test")
  end

  it "returns the post-match (in the regular expression sense) of the last scan" do
    @s.post_match.should == nil
    @s.scan(/\w+\s/)
    @s.post_match.should == "is a test"
    @s.getch
    @s.post_match.should == "s a test"
    @s.get_byte
    @s.post_match.should == " a test"
    @s.get_byte
    @s.post_match.should == "a test"
  end

  it "returns nil if there's no match" do
    @s.scan(/\s+/)
    @s.post_match.should == nil
  end
end
