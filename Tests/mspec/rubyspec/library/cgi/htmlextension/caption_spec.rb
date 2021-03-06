require File.dirname(__FILE__) + '/../../../spec_helper'
require 'cgi'
require File.dirname(__FILE__) + "/fixtures/common"

describe "CGI::HtmlExtension#caption" do
  before(:each) do
    @html = CGISpecs::HtmlExtension.new
  end
  
  describe "when passed a String" do
    it "returns a 'caption'-element, using the passed String for the 'align'-attribute" do
      output = @html.caption("left")
      output.should equal_element("CAPTION", "ALIGN" => "left")
    end
  
    it "includes the passed block's return value when passed a block" do
      output = @html.caption("left") { "Capital Cities" }
      output.should equal_element("CAPTION", {"ALIGN" => "left"}, "Capital Cities")
    end
  end
  
  describe "when passed a Hash" do
    it "returns a 'caption'-element, using the passed Hash for attributes" do
      output = @html.caption("ALIGN" => "left", "ID" => "test")
      output.should equal_element("CAPTION", "ALIGN" => "left", "ID" => "test")
    end
  
    it "includes the passed block's return value when passed a block" do
      output = @html.caption("ALIGN" => "left", "ID" => "test") { "Capital Cities" }
      output.should equal_element("CAPTION", {"ALIGN" => "left", "ID" => "test"}, "Capital Cities")
    end
  end
end
