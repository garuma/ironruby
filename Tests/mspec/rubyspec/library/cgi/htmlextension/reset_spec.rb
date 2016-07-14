require File.dirname(__FILE__) + '/../../../spec_helper'
require 'cgi'
require File.dirname(__FILE__) + "/fixtures/common"

describe "CGI::HtmlExtension#reset" do
  before(:each) do
    @html = CGISpecs::HtmlExtension.new
  end

  describe "when passed no arguments" do
    it "returns a reset-'input'-element" do
      output = @html.reset
      output.should equal_element("INPUT", {"TYPE" => "reset"}, "", :not_closed => true)
    end
  
    it "ignores a passed block" do
      output = @html.reset { "test" }
      output.should equal_element("INPUT", {"TYPE" => "reset"}, "", :not_closed => true)
    end
  end

  describe "when passed value" do
    it "returns a reset-'input'-element with the passed value" do
      output = @html.reset("Example")
      output.should equal_element("INPUT", {"TYPE" => "reset", "VALUE" => "Example"}, "", :not_closed => true)
    end
  
    it "ignores a passed block" do
      output = @html.reset("Example") { "test" }
      output.should equal_element("INPUT", {"TYPE" => "reset", "VALUE" => "Example"}, "", :not_closed => true)
    end
  end

  describe "when passed value, name" do
    it "returns a reset-'input'-element with the passed value and the passed name" do
      output = @html.reset("Example", "test-name")
      output.should equal_element("INPUT", {"TYPE" => "reset", "VALUE" => "Example", "NAME" => "test-name"}, "", :not_closed => true)
    end
  
    it "ignores a passed block" do
      output = @html.reset("Example", "test-name") { "test" }
      output.should equal_element("INPUT", {"TYPE" => "reset", "VALUE" => "Example", "NAME" => "test-name"}, "", :not_closed => true)
    end
  end

  describe "when passed Hash" do
    it "returns a reset-'input'-element with the passed value" do
      output = @html.reset("Example")
      output.should equal_element("INPUT", {"TYPE" => "reset", "VALUE" => "Example"}, "", :not_closed => true)
    end
  
    it "ignores a passed block" do
      output = @html.reset("Example") { "test" }
      output.should equal_element("INPUT", {"TYPE" => "reset", "VALUE" => "Example"}, "", :not_closed => true)
    end
  end
end
