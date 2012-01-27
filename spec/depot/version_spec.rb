require "spec_helper"

describe Depot do

  let(:version) { Depot::VERSION }

  it "should be a triplet" do
    version.should match(/^\d+\.\d+\.\d+$/)
  end

end
