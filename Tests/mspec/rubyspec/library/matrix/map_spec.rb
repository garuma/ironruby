require File.dirname(__FILE__) + '/../../spec_helper'
require File.dirname(__FILE__) + '/shared/collect'
require 'matrix'

describe "Matrix#map" do
  it_behaves_like(:collect, :map)
end