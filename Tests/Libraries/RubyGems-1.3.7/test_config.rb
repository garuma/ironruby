require File.expand_path('../gemutilities', __FILE__)
require 'rubygems'

class TestConfig < RubyGemTestCase

  def test_datadir
    datadir = RbConfig::CONFIG['datadir']
    assert_equal "#{datadir}/xyz", RbConfig.datadir('xyz')
  end

end

