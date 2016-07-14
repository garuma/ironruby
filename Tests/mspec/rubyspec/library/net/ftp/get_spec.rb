require File.dirname(__FILE__) + '/../../../spec_helper'
require 'net/ftp'
require File.dirname(__FILE__) + "/fixtures/server"
require File.dirname(__FILE__) + "/shared/gettextfile"
require File.dirname(__FILE__) + "/shared/getbinaryfile"

describe "Net::FTP#get (binary mode)" do
  before(:each) do
    @binary_mode = true
  end
  
  it_behaves_like :net_ftp_getbinaryfile, :get
end

describe "Net::FTP#get (text mode)" do
  before(:each) do
    @binary_mode = false
  end
  
  it_behaves_like :net_ftp_gettextfile, :get
end
