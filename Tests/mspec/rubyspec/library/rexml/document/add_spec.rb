require 'rexml/document'
require File.dirname(__FILE__) + '/../../../spec_helper'

# This spec defines Document#add and Document#<<

describe :rexml_document_add, :shared => true do
  before :each do
    @doc  = REXML::Document.new("<root/>")
    @decl = REXML::XMLDecl.new("1.0")
  end

  it "sets document's XML declaration" do
    @doc.send(@method, @decl)
    @doc.xml_decl.should == @decl
  end

  it "inserts XML declaration as first node" do
    @doc.send(@method, @decl)
    @doc.children[0].version.should == "1.0"
  end

  it "overwrites existing XML declaration" do
    @doc.send(@method, @decl)
    @doc.send(@method, REXML::XMLDecl.new("2.0"))
    @doc.xml_decl.version.should == "2.0"
  end

  it "sets document DocType" do
    @doc.send(@method, REXML::DocType.new("transitional"))
    @doc.doctype.name.should == "transitional"
  end

  ruby_bug "#19058", "1.8" do
    # MRI 1.8.x and 1.9 bug. A patch has been submitted.
    # http://rubyforge.org/tracker/index.php?func=detail&aid=19058&group_id=426&atid=1698
    it "overwrites existing DocType" do
      @doc.send(@method, REXML::DocType.new("transitional"))
      @doc.send(@method, REXML::DocType.new("strict"))
      @doc.doctype.name.should == "strict"
    end
  end

  it "adds root node unless it exists" do
    d = REXML::Document.new("")
    elem = REXML::Element.new "root"
    d.send(@method, elem)
    d.root.should == elem
  end

  it "refuses to add second root" do
    lambda { @doc.send(@method, REXML::Element.new("foo")) }.should raise_error(RuntimeError)
  end
end

describe "REXML::Document#add" do
  it_behaves_like(:rexml_document_add, :add)
end

describe "REXML::Document#<<" do
  it_behaves_like(:rexml_document_add, :<<)
end
