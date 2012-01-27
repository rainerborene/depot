require "spec_helper"

describe Depot::Context do

  before do
    User.stub!(:find_or_create_by_name)
    @base = Depot::Base.new
  end

  subject { described_class.new(User, @base) }

  describe "#initialize" do
    its(:klass) { should eql User }
    its(:base) { should eql @base }
  end

  describe "#finder" do
    it "should change the finder criteria" do
      attributes = { email: "jonh@doe.com" }
      User.should_receive(:find_or_create_by_email).with(attributes)
      subject.finder(:email)
      subject.create(attributes)
    end
  end

  describe "#create" do
    it "should create a new entry given a hash" do
      subject.create({ name: "Jonh Doe", email: "jonh@doe.com", :as => :jonh_doe })
      @base.entries.should_not be_empty
      @base.entries.should have_key :jonh_doe
    end

    it "should create a new entry given a block" do
      subject.create :as => :jonh_doe do |p|
        p.name = "Jonh Doe"
        p.email = "jonh@doe.com"
      end

      @base.entries.should_not be_empty
      @base.entries.should have_key :jonh_doe
    end
  end

end
