require 'spec_helper'

describe Local do

  before( :each ) do
    @status = stub_model( Status, :value => "Active" )

    @local = Local.new( :value => "Joaquim Neto", :status => @status, :user => "1" )
  end

  it "can be an instance" do
    @local.should be_an_instance_of( Local )
  end

  it "can be save successfully" do
    @local.save.should == true
  end

  it "should not be an instance valid cause the property 'value' is nil" do
    @local.value= nil
    @local.should_not be_valid
  end

  it "should not be an instance valid cause the property 'status' is nil" do
    @local.status= nil
    @local.should_not be_valid
  end

  it "should not be an instance valid cause the property 'user' is nil" do
    @local.user= nil
    @local.should_not be_valid
  end

  it "should not be an instance valid if the length of 'value' property is equal zero" do
    @local.value= ''
    @local.should_not be_valid
  end

  it "should be an instance valid if the length of 'value' property is between one and eighty" do
    @local.value= 'This is a big text to test a validate for the length of this property.'
    @local.should be_valid
  end

  it "should not be an instance valid if the length of 'value' property is greater than eighty" do
    @local.value= 'This is a big text to test a validate for the length of this property. If greater this instance is not valid.'
    @local.should_not be_valid
  end

  it "should not be an instance valid if the length of 'user' property is equal zero" do
    @local.user= ''
    @local.should_not be_valid
  end

  it "Status should be equal to :status_id" do
    @local.status.should eq( @status )
  end

  it "Status' value should be equal to :status_id's value" do
    @local.status.value.should eq( @status.value )
  end

  it "should not permit to create a new register with an existing 'value' registered" do
    @local.save

    @local_invalid = Local.new( :value => "Joaquim Neto", :status => @status, :user => "1" )
    @local_invalid.save.should == false
  end

  it "should not permit to create a new register with an existing 'value' registered" do
    @local.save

    @local_valid = Local.new( :value => "Santa Maria", :status => @status, :user => "1" )
    @local_valid.save.should == true
  end

end
