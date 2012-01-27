require "spec_helper"

describe Depot::Base do

  subject { described_class.new }

  before do
    User.stub!(:find_or_create_by_name)
  end

  describe "#initialize" do
    it "should initialize entries hash" do
      subject.entries.should be_empty
      subject.entries.should be_instance_of Hash
    end

    it "should disable logging by default" do
      subject.instance_variable_get(:@logging).should be_false
    end
  end

  describe "#inject" do
    it "should append a new symbol to the models set" do
      subject.inject :jobs
      subject.models.should include :jobs
    end
  end

  describe "#method_missing" do
    before { subject.inject :users }

    it "should listen to model names" do
      lambda {
        subject.users do
          # something
        end
      }.should_not raise_error
    end
    
    it "should listen to entries key name" do
      subject.users do
        create({ name: "Jonh Doe", email: "jonh@doe.com", as: :jonh })
      end
      subject.entries.should have_key :jonh
      lambda { subject.jonh }.should_not raise_error
    end

    it "should fallback to the default behavior" do
      lambda { subject.say_hello }.should raise_error
    end
  end

end
