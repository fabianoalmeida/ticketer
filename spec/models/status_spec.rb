require 'spec_helper'

describe Status do

  before( :each ) do
    @status = FactoryGirl.build(:status)
  end

  it "can be instantiated" do
    @status.should be_an_instance_of( Status )
  end

  it "can be saved successfully" do
    @status.save.should == true
  end

  it "should be an instance valid" do
    @status.should be_valid
  end
  
  it "should not be an instance valid if 'value' property is nil" do
    @status.value= nil
    @status.should_not be_valid
  end

  it "should not be an instance valid if 'user' property is nil" do
    @status.user= nil
    @status.should_not be_valid
  end
  
  it "should not be an instance valid with length of 'value' equal zero" do
    @status.value= ''
    @status.should_not be_valid
  end
  
  it "should not be an instance valid with length of 'user' equal zero" do
    @status.user= ''
    @status.should_not be_valid
  end

  it "should be an instance valid with length of 'value' between one and eighty" do
    @status.value= 'This is a big text to test a validate for the length of this property.'
    @status.should be_valid
  end

  it "should not be an instance valid with length of 'value' greater than eighty" do
    @status.value= 'This is a big text to test a validate for the length of this property. If greater this instance is not valid.'
    @status.should_not be_valid
  end

  it "should not be create a register with an existing 'value' registered" do
    @status.save

    @status_invalid = FactoryGirl.build( :status, :value => @status.value )
    @status_invalid.save.should be_false
  end

  it "should be returned a Status with value equal 'Active'" do
    @status.value= "Active"
    @status.save

    @status_active = Status.active
    @status_active.value.should eq( "Active" )
  end

  it "should be returned a Status with value equal 'Inactive'" do
    @status_new = Status.new( :value => "Inactive", :user => "1" )
    @status_new.save

    @status_inactive = Status.inactive
    @status_inactive.value.should eq( "Inactive" )
  end

end
