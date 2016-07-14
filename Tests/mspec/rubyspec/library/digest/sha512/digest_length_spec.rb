require File.dirname(__FILE__) + '/../../../spec_helper'
require File.dirname(__FILE__) + '/shared/constants'

describe "Digest::SHA512#digest_length" do

  it 'returns the length of computed digests' do
    cur_digest = Digest::SHA512.new
    cur_digest.digest_length.should == SHA512Constants::DigestLength
  end

end

