require 'spec_helper'

describe Guidance do

  before( :each ) do
    @guidance = Guidance.new( :value => "Left", :user => "1" )
  end

  it "can be an instance" do
    @guidance.should be_an_instance_of( Guidance )
  end

  it "can be save successfully" do
    @guidance.save.should == true
  end

  it "should be an instance valid" do
    @guidance.should be_valid
  end

  it "should not be an instance valid if the 'value' property is nil" do
    @guidance.value= nil
    @guidance.should_not be_valid
  end

  it "should not be an instance valid if the length of 'value' property is equal zero" do
    @guidance.value= ''
    @guidance.should_not be_valid
  end

  it "should be an instance valid if the length of 'value' property is between one and twenty" do
    @guidance.value= 'This is a big text.'
    @guidance.should be_valid
  end

  it "should not be an instance valid if the length of 'value' property is greater than twenty" do
    @guidance.value= 'This is a big text to test a validate for the length of this property. If greater this instance is not valid.'
    @guidance.should_not be_valid
  end
  
  it "should not be an instance valid if the 'user' property is nil" do
    @guidance.user= nil
    @guidance.should_not be_valid
  end
  
  it "should not be an instance valid if the length of 'user' property is equal zero" do
    @guidance.user= ''
    @guidance.should_not be_valid
  end

  it "should not permit to create a new register with an existing 'value' registered" do
    @guidance.save

    @guidanceInvalid = Guidance.new( :value => "Left", :user => "1" )
    @guidanceInvalid.save.should == false
  end

  it "should permit to create a new register with an unexisting 'value' registered" do
    @guidance.save

    @guidanceValid = Guidance.new( :value => "Right", :user => "1" )
    @guidanceValid.save.should == true
  end

end
