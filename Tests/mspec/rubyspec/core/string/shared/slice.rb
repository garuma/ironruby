describe :string_slice, :shared => true do
  before(:each) do
    @hello ||= "hello"
    @empty ||= ""
  end
  it "returns the character code of the character at the given index" do
    @hello.send(@method, 0).should == ?h
    @hello.send(@method, -1).should == ?o
  end

  it "returns nil if index is outside of self" do
    @hello.send(@method, 20).should == nil
    @hello.send(@method, -20).should == nil

    @empty.send(@method, 0).should == nil
    @empty.send(@method, -1).should == nil
  end

  it "calls to_int on the given index" do
    @hello.send(@method, 0.5).should == ?h

    obj = mock('1')
    obj.should_receive(:to_int).and_return(1)
    @hello.send(@method, obj).should == ?e
  end

  it "raises a TypeError if the given index is nil" do
    lambda { @hello.send(@method, nil) }.should raise_error(TypeError)
  end

  it "raises a TypeError if the given index can't be converted to an Integer" do
    lambda { @hello.send(@method, mock('x')) }.should raise_error(TypeError)
    lambda { @hello.send(@method, {})        }.should raise_error(TypeError)
    lambda { @hello.send(@method, [])        }.should raise_error(TypeError)
  end
end

describe :string_slice_index_length, :shared => true do
  before(:each) do
    @hello_there ||= "hello there"
    @hello ||= "hello"
    @empty ||= ""
    @foo ||= "foo"
    @x ||= "x"
  end
  
  it "returns the substring starting at the given index with the given length" do
    @hello_there.send(@method, 0,0).should == ""
    @hello_there.send(@method, 0,1).should == "h"
    @hello_there.send(@method, 0,3).should == "hel"
    @hello_there.send(@method, 0,6).should == "hello "
    @hello_there.send(@method, 0,9).should == "hello the"
    @hello_there.send(@method, 0,12).should == "hello there"

    @hello_there.send(@method, 1,0).should == ""
    @hello_there.send(@method, 1,1).should == "e"
    @hello_there.send(@method, 1,3).should == "ell"
    @hello_there.send(@method, 1,6).should == "ello t"
    @hello_there.send(@method, 1,9).should == "ello ther"
    @hello_there.send(@method, 1,12).should == "ello there"

    @hello_there.send(@method, 3,0).should == ""
    @hello_there.send(@method, 3,1).should == "l"
    @hello_there.send(@method, 3,3).should == "lo "
    @hello_there.send(@method, 3,6).should == "lo the"
    @hello_there.send(@method, 3,9).should == "lo there"

    @hello_there.send(@method, 4,0).should == ""
    @hello_there.send(@method, 4,3).should == "o t"
    @hello_there.send(@method, 4,6).should == "o ther"
    @hello_there.send(@method, 4,9).should == "o there"

    @foo.send(@method, 2,1).should == "o"
    @foo.send(@method, 3,0).should == ""
    @foo.send(@method, 3,1).should == ""

    @empty.send(@method, 0,0).should == ""
    @empty.send(@method, 0,1).should == ""

    @x.send(@method, 0,0).should == ""
    @x.send(@method, 0,1).should == "x"
    @x.send(@method, 1,0).should == ""
    @x.send(@method, 1,1).should == ""

    @x.send(@method, -1,0).should == ""
    @x.send(@method, -1,1).should == "x"

    @hello_there.send(@method, -3,2).should == "er"
  end

  it "always taints resulting strings when self is tainted" do
    str = "hello world"
    str.taint

    str.send(@method, 0,0).tainted?.should == true
    str.send(@method, 0,1).tainted?.should == true
    str.send(@method, 2,1).tainted?.should == true
  end

  it "returns nil if the offset falls outside of self" do
    @hello_there.send(@method, 20,3).should == nil
    @hello_there.send(@method, -20,3).should == nil

    @empty.send(@method, 1,0).should == nil
    @empty.send(@method, 1,1).should == nil

    @empty.send(@method, -1,0).should == nil
    @empty.send(@method, -1,1).should == nil

    @x.send(@method, 2,0).should == nil
    @x.send(@method, 2,1).should == nil

    @x.send(@method, -2,0).should == nil
    @x.send(@method, -2,1).should == nil
  end

  it "returns nil if the length is negative" do
    @hello_there.send(@method, 4,-3).should == nil
    @hello_there.send(@method, -4,-3).should == nil
  end

  it "calls to_int on the given index and the given length" do
    @hello.send(@method, 0.5, 1).should == "h"
    @hello.send(@method, 0.5, 2.5).should == "he"
    @hello.send(@method, 1, 2.5).should == "el"

    obj = mock('2')
    obj.should_receive(:to_int).exactly(4).times.and_return(2)

    @hello.send(@method, obj, 1).should == "l"
    @hello.send(@method, obj, obj).should == "ll"
    @hello.send(@method, 0, obj).should == "he"
  end

  it "raises a TypeError when idx or length can't be converted to an integer" do
    lambda { @hello.send(@method, mock('x'), 0) }.should raise_error(TypeError)
    lambda { @hello.send(@method, 0, mock('x')) }.should raise_error(TypeError)

    # I'm deliberately including this here.
    # It means that str.send(@method, other, idx) isn't supported.
    lambda { @hello.send(@method, "", 0) }.should raise_error(TypeError)
  end

  it "raises a TypeError when the given index or the given length is nil" do
    lambda { @hello.send(@method, 1, nil)   }.should raise_error(TypeError)
    lambda { @hello.send(@method, nil, 1)   }.should raise_error(TypeError)
    lambda { @hello.send(@method, nil, nil) }.should raise_error(TypeError)
  end

  it "returns subclass instances" do
    s = StringSpecs::MyString.new(@hello)
    s.send(@method, 0,0).class.should == StringSpecs::MyString
    s.send(@method, 0,4).class.should == StringSpecs::MyString
    s.send(@method, 1,4).class.should == StringSpecs::MyString
  end
end

describe :string_slice_range, :shared => true do
  before(:each) do
    @hello_there ||= "hello there"
    @hello ||= "hello"
    @hello_world ||= "hello world"
    @empty ||= ""
    @x ||= "x"
    @good ||= "GOOD"
  end
  it "returns the substring given by the offsets of the range" do
    @hello_there.send(@method, 1..1).should == "e"
    @hello_there.send(@method, 1..3).should == "ell"
    @hello_there.send(@method, 1...3).should == "el"
    @hello_there.send(@method, -4..-2).should == "her"
    @hello_there.send(@method, -4...-2).should == "he"
    @hello_there.send(@method, 5..-1).should == " there"
    @hello_there.send(@method, 5...-1).should == " ther"

    @empty.send(@method, 0..0).should == ""

    @x.send(@method, 0..0).should == "x"
    @x.send(@method, 0..1).should == "x"
    @x.send(@method, 0...1).should == "x"
    @x.send(@method, 0..-1).should == "x"

    @x.send(@method, 1..1).should == @empty
    @x.send(@method, 1..-1).should == @empty
  end

  it "returns nil if the beginning of the range falls outside of self" do
    @hello_there.send(@method, 12..-1).should == nil
    @hello_there.send(@method, 20..25).should == nil
    @hello_there.send(@method, 20..1).should == nil
    @hello_there.send(@method, -20..1).should == nil
    @hello_there.send(@method, -20..-1).should == nil

    @empty.send(@method, -1..-1).should == nil
    @empty.send(@method, -1...-1).should == nil
    @empty.send(@method, -1..0).should == nil
    @empty.send(@method, -1...0).should == nil
  end

  it "returns an empty string if range.begin is inside self and > real end" do
    @hello_there.send(@method, 1...1).should == @empty
    @hello_there.send(@method, 4..2).should == @empty
    @hello.send(@method, 4..-4).should == @empty
    @hello_there.send(@method, -5..-6).should == @empty
    @hello_there.send(@method, -2..-4).should == @empty
    @hello_there.send(@method, -5..-6).should == @empty
    @hello_there.send(@method, -5..2).should == @empty

    @empty.send(@method, 0...0).should == ""
    @empty.send(@method, 0..-1).should == ""
    @empty.send(@method, 0...-1).should == ""

    @x.send(@method, 0...0).should == @empty
    @x.send(@method, 0...-1).should == @empty
    @x.send(@method, 1...1).should == @empty
    @x.send(@method, 1...-1).should == @empty
  end

  it "always taints resulting strings when self is tainted" do
    str = @hello_world
    str.taint

    str.send(@method, 0..0).tainted?.should == true
    str.send(@method, 0...0).tainted?.should == true
    str.send(@method, 0..1).tainted?.should == true
    str.send(@method, 0...1).tainted?.should == true
    str.send(@method, 2..3).tainted?.should == true
    str.send(@method, 2..0).tainted?.should == true
  end

  it "returns subclass instances" do
    s = StringSpecs::MyString.new(@hello)
    s.send(@method, 0...0).class.should == StringSpecs::MyString
    s.send(@method, 0..4).class.should == StringSpecs::MyString
    s.send(@method, 1..4).class.should == StringSpecs::MyString
  end

  it "calls to_int on range arguments" do
    from = mock('from')
    to = mock('to')

    # So we can construct a range out of them...
    from.should_receive(:<=>).twice.and_return(0)

    from.should_receive(:to_int).twice.and_return(1)
    to.should_receive(:to_int).twice.and_return(-2)

    @hello_there.send(@method, from..to).should == "ello ther"
    @hello_there.send(@method, from...to).should == "ello the"
  end

  it "works with Range subclasses" do
    a = @good
    range_incl = StringSpecs::MyRange.new(1, 2)
    range_excl = StringSpecs::MyRange.new(-3, -1, true)

    a.send(@method, range_incl).should == "OO"
    a.send(@method, range_excl).should == "OO"
  end
end

describe :string_slice_regexp, :shared => true do
  before(:each) do
    @hello_there ||= "hello there"
    @hello ||= "hello"
    @hello_world ||= "hello world"
    @empty ||= ""
    @x ||= "x"
    @good ||= "GOOD"
  end
  it "returns the matching portion of self" do
    @hello_there.send(@method, /[aeiou](.)\1/).should == "ell"
    @empty.send(@method, //).should == ""
  end

  it "returns nil if there is no match" do
    @hello_there.send(@method, /xyz/).should == nil
  end

  it "always taints resulting strings when self or regexp is tainted" do
    strs = [@hello_world]
    strs += strs.map { |s| s.dup.taint }

    strs.each do |str|
      str.send(@method, //).tainted?.should == str.tainted?
      str.send(@method, /hello/).tainted?.should == str.tainted?

      tainted_re = /./
      tainted_re.taint

      str.send(@method, tainted_re).tainted?.should == true
    end
  end

  it "returns subclass instances" do
    s = StringSpecs::MyString.new(@hello)
    s.send(@method, //).class.should == StringSpecs::MyString
    s.send(@method, /../).class.should == StringSpecs::MyString
  end

  it "sets $~ to MatchData when there is a match and nil when there's none" do
    @hello.send(@method, /./)
    $~[0].should == 'h'

    @hello.send(@method, /not/)
    $~.should == nil
  end
end

describe :string_slice_regexp_index, :shared => true do
  before(:each) do
    @hello_there ||= "hello there"
    @hello ||= "hello"
    @hello_world ||= "hello world"
    @empty ||= ""
    @x ||= "x"
    @good ||= "GOOD"
    @har ||= "har"
  end
  it "returns the capture for the given index" do
    @hello_there.send(@method, /[aeiou](.)\1/, 0).should == "ell"
    @hello_there.send(@method, /[aeiou](.)\1/, 1).should == "l"
    @hello_there.send(@method, /[aeiou](.)\1/, -1).should == "l"

    @har.send(@method, /(.)(.)(.)/, 0).should == "har"
    @har.send(@method, /(.)(.)(.)/, 1).should == "h"
    @har.send(@method, /(.)(.)(.)/, 2).should == "a"
    @har.send(@method, /(.)(.)(.)/, 3).should == "r"
    @har.send(@method, /(.)(.)(.)/, -1).should == "r"
    @har.send(@method, /(.)(.)(.)/, -2).should == "a"
    @har.send(@method, /(.)(.)(.)/, -3).should == "h"
  end

  it "always taints resulting strings when self or regexp is tainted" do
    strs = [@hello_world]
    strs += strs.map { |s| s.dup.taint }

    strs.each do |str|
      str.send(@method, //, 0).tainted?.should == str.tainted?
      str.send(@method, /hello/, 0).tainted?.should == str.tainted?

      str.send(@method, /(.)(.)(.)/, 0).tainted?.should == str.tainted?
      str.send(@method, /(.)(.)(.)/, 1).tainted?.should == str.tainted?
      str.send(@method, /(.)(.)(.)/, -1).tainted?.should == str.tainted?
      str.send(@method, /(.)(.)(.)/, -2).tainted?.should == str.tainted?

      tainted_re = /(.)(.)(.)/
      tainted_re.taint

      str.send(@method, tainted_re, 0).tainted?.should == true
      str.send(@method, tainted_re, 1).tainted?.should == true
      str.send(@method, tainted_re, -1).tainted?.should == true
    end
  end

  it "returns nil if there is no match" do
    @hello_there.send(@method, /(what?)/, 1).should == nil
  end

  it "returns nil if there is no capture for the given index" do
    @hello_there.send(@method, /[aeiou](.)\1/, 2).should == nil
    # You can't refer to 0 using negative indices
    @hello_there.send(@method, /[aeiou](.)\1/, -2).should == nil
  end

  it "calls to_int on the given index" do
    obj = mock('2')
    obj.should_receive(:to_int).and_return(2)

    @har.send(@method, /(.)(.)(.)/, 1.5).should == "h"
    @har.send(@method, /(.)(.)(.)/, obj).should == "a"
  end

  it "raises a TypeError when the given index can't be converted to Integer" do
    lambda { @hello.send(@method, /(.)(.)(.)/, mock('x')) }.should raise_error(TypeError)
    lambda { @hello.send(@method, /(.)(.)(.)/, {})        }.should raise_error(TypeError)
    lambda { @hello.send(@method, /(.)(.)(.)/, [])        }.should raise_error(TypeError)
  end

  it "raises a TypeError when the given index is nil" do
    lambda { @hello.send(@method, /(.)(.)(.)/, nil) }.should raise_error(TypeError)
  end

  it "returns subclass instances" do
    s = StringSpecs::MyString.new(@hello)
    s.send(@method, /(.)(.)/, 0).class.should == StringSpecs::MyString
    s.send(@method, /(.)(.)/, 1).class.should == StringSpecs::MyString
  end

  it "sets $~ to MatchData when there is a match and nil when there's none" do
    @hello.send(@method, /.(.)/, 0)
    $~[0].should == 'he'

    @hello.send(@method, /.(.)/, 1)
    $~[1].should == 'e'

    @hello.send(@method, /not/, 0)
    $~.should == nil
  end
end

describe :string_slice_string, :shared => true do
  before(:each) do
    @hello_there ||= "hello there"
    @hello ||= "hello"
    @hello_world ||= "hello world"
    @empty ||= ""
    @x ||= "x"
    @good ||= "GOOD"
  end
  it "returns other_str if it occurs in self" do
    s = "lo"
    @hello_there.send(@method, s).should == s
  end

  it "taints resulting strings when other is tainted" do
    strs = [@empty, @hello_world, @hello]
    strs += strs.map { |s| s.dup.taint }

    strs.each do |str|
      strs.each do |other|
        r = str.send(@method, other)

        r.tainted?.should == !r.nil? & other.tainted?
      end
    end
  end

  it "doesn't set $~" do
    $~ = nil

    @hello.send(@method, 'll')
    $~.should == nil
  end

  it "returns nil if there is no match" do
    @hello_there.send(@method, "bye").should == nil
  end

  it "doesn't call to_str on its argument" do
    o = mock('x')
    o.should_not_receive(:to_str)

    lambda { @hello.send(@method, o) }.should raise_error(TypeError)
  end

  it "returns a subclass instance when given a subclass instance" do
    s = StringSpecs::MyString.new("el")
    r = @hello.send(@method, s)
    r.should == "el"
    r.class.should == StringSpecs::MyString
  end
end

language_version __FILE__, "slice"
