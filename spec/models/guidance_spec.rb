require 'spec_helper'

describe Guidance do

  before( :each ) do
    @guidance = Factory.build(:guidance)
  end

  it "can be save successfully" do
    @guidance.save.should be_true
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
    Factory(:guidance, :value => "Value 1" )
    @guidanceInvalid = Factory.build(:guidance, :value => "Value 1" )
    @guidanceInvalid.save.should be_false
  end

end
