require File.dirname(__FILE__) + '/../../spec_helper'

describe "Float#CONSTANTS" do
  specify  "the DIG value is  15" do
    Float::DIG.should == 15
  end

  it "the EPSILON value is " do
    Float::EPSILON.should == eval("0.0000000000000002220446049250313080847263336181640625")
  end

  it "the MANT_DIG is 53" do
    Float::MANT_DIG.should == 53
  end

  it "the MAX_10_EXP is 308" do
    Float::MAX_10_EXP.should == 308
  end

  it "the MIN_10_EXP is -308" do
    Float::MIN_10_EXP.should == -307
  end

  it "the MAX_EXP is 1024" do
    Float::MAX_EXP.should == 1024
  end

  it "the MIN_EXP is -1021" do
    Float::MIN_EXP.should == -1021
  end

  it "the MAX is 1.79769313486232e+308" do
    Float::MAX.should == eval("179769313486231570814527423731704356798070567525844996598917476803157260780028538760589558632766878171540458953514382464234321326889464182768467546703537516986049910576551282076245490090389328944075868508455133942304583236903222948165808559332123348274797826204144723168738177180919299881250404026184124858368.0")
  end

  ruby_bug "", "1.8.6.362" do
    not_compliant_on :jruby do
      it "the MIN is 2.2250738585072e-308" do
        Float::MIN.should == eval("2.225073858507201383090232717332404064219215980462331830553327416887204434813918195854283159012511020564067339731035811005152434161553460108856012385377718821130777993532002330479610147442583636071921565046942503734208375250806650616658158948720491179968591639648500635908770118304874799780887753749949451580451605050915399856582470818645113537935804992115981085766051992433352114352390148795699609591288891602992641511063466313393663477586513029371762047325631781485664350872122828637642044846811407613911477062801689853244110024161447421618567166150540154285084716752901903161322778896729707373123334086988983175067838846926092773977972858659654941091369095406136467568702398678315290680984617210924625396728515625e-308")
      end
    end
  end

  # TODO: Does this actually constitute noncompliance?
  deviates_on :jruby do
    it "the MIN is 4.9e-324" do
      Float::MIN.should == 4.9e-324
    end
  end

  it "the RADIX is 2" do
    Float::RADIX.should == 2
  end
end
