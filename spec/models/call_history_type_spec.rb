require 'spec_helper'

describe CallHistoryType do

  before( :each ) do
    @callHistoryType = CallHistoryType.new( :value => "Called", :acronym => "C", :user => "1" )
  end

  it "can be an instance" do
    @callHistoryType.should be_an_instance_of( CallHistoryType )
  end

  it "can be save successfully" do
    @callHistoryType.save.should == true
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

    @callHistoryTypeInvalid = CallHistoryType.new( :value => "Called", :acronym => "C", :user => "1" )
    @callHistoryTypeInvalid.save.should == false
  end

  it "should permit to create a new register with an unexisting 'value' registered" do
    @callHistoryType.save

    @callHistoryTypeInvalid = CallHistoryType.new( :value => "Attended", :acronym => "A", :user => "1" )
    @callHistoryTypeInvalid.save.should == true
  end

  it "should not be an instance valid if the 'acronym' property is nil" do
    @callHistoryType.acronym= nil
    @callHistoryType.should_not be_valid
  end
  
  it "should not be an instance valid if the length of 'acronym' property is equal zero" do
    @callHistoryType.acronym= ''
    @callHistoryType.should_not be_valid
  end

  it "should be an instance valid if the length of 'acronym' property is equal one" do
    @callHistoryType.acronym= 'C'
    @callHistoryType.should be_valid
  end

  it "should not be an instance valid if the length of 'acronym' property is different from one" do
    @callHistoryType.acronym= 'CL'
    @callHistoryType.should_not be_valid
  end

  it "should not permit to create a new register with an existing 'acronym' registered" do
    @callHistoryType.save

    @callHistoryTypeInvalid = CallHistoryType.new( :value => "Chosen", :acronym => "C", :user => "1" )
    @callHistoryTypeInvalid.save.should == false
  end

  it "should permit to create a new register with an unexisting 'acronym' registered" do
    @callHistoryType.save

    @callHistoryTypeInvalid = CallHistoryType.new( :value => "Called Again", :acronym => "A", :user => "1" )
    @callHistoryTypeInvalid.save.should == true
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
