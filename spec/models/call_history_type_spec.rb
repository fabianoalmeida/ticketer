require 'spec_helper'

describe CallHistoryType do

  before( :each ) do
    @callHistoryType = Factory.build(:call_history_type)
  end

  it "can be save successfully" do
    @callHistoryType.save.should be_true
  end

  it "should be an instance valid" do
    @callHistoryType.should be_valid
  end

  it "should not be an instance valid if the 'value' property is nil" do
    @callHistoryType.value= nil
    @callHistoryType.should_not be_valid
  end

  it "should not be an instance valid if the length of 'value' property is equal zero" do
    @callHistoryType.value= ''
    @callHistoryType.should_not be_valid
  end

  it "should be an instance valid if the length of 'value' property is between one and eighty" do
    @callHistoryType.value= 'This is a big text to test a validate for the length of this property.'
    @callHistoryType.should be_valid
  end

  it "should not be an instance valid if the length of 'value' property is greater than eighty" do
    @callHistoryType.value= 'This is a big text to test a validate for the length of this property. If greater this instance is not valid.'
    @callHistoryType.should_not be_valid
  end

  it "should not permit to create a new register with an existing 'value' registered" do
    @callHistoryType.save

    @callHistoryTypeInvalid = Factory.build(:call_history_type, :value => @callHistoryType.value)
    @callHistoryTypeInvalid.save.should == false
  end

  it "should permit to create a new register with an unexisting 'value' registered" do
    @callHistoryType.save.should == true
  end

  it "should not be an instance valid if the 'acronym' property is nil" do
    @callHistoryType.acronym= nil
    @callHistoryType.should_not be_valid
  end
  
  it "should not be an instance valid if the length of 'acronym' property is equal zero" do
    @callHistoryType.acronym= ''
    @callHistoryType.should_not be_valid
  end

  it "should not be an instance valid if the length of 'acronym' property is greatest than 3" do
    @callHistoryType.acronym= 'CL34'
    @callHistoryType.should_not be_valid
  end

  it "should not permit to create a new register with an existing 'acronym' registered" do
    @callHistoryType.save

    @callHistoryTypeInvalid = Factory.build(:call_history_type, :acronym => @callHistoryType.acronym )
    @callHistoryTypeInvalid.save.should be_false
  end
  
  it "should not be an instance valid if the 'user' property is nil" do
    @callHistoryType.user= nil
    @callHistoryType.should_not be_valid
  end
  
  it "should not be an instance valid if the length of 'user' property is equal zero" do
    @callHistoryType.user= ''
    @callHistoryType.should_not be_valid
  end

end
