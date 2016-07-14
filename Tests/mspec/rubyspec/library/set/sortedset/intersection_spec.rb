require File.dirname(__FILE__) + '/../../../spec_helper'
require File.dirname(__FILE__) + '/shared/intersection'
require 'set'

describe "SortedSet#intersection" do
  it_behaves_like :sorted_set_intersection, :intersection
end

describe "SortedSet#&" do
  it_behaves_like :sorted_set_intersection, :&
end
