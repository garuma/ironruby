require File.dirname(__FILE__) + '/../../spec_helper'
require 'rational'

describe :rational_hash, :shared => true do
  # BUG: Rational(2, 3).hash == Rational(3, 2).hash
  it "is static" do
    Rational(2, 3).hash.should == Rational(2, 3).hash
    Rational(2, 4).hash.should_not == Rational(2, 3).hash
  end
end
