require 'spec_helper'

describe Panel do

  before( :each ) do
    @status = stub_model( Status, :value => "Active" )

    @panel = Panel.new( :value => "Panel 01", :ip => "10.32.1.22", :status => @status, :user => "1" )
  end

  it "can be an instance" do
    @panel.should be_an_instance_of( Panel )
  end
  
  it "can be save successfully" do
    @panel.save.should == true
  end

  it "should not be an instanve valid if the property 'value' is nil" do
    @panel.value= nil
    @panel.should_not be_valid
  end

  it "should not be an instance valid if the length of 'value' property is equal zero" do
    @panel.value= ''
    @panel.should_not be_valid
  end

  it "should be an instance valid if the length of 'value' property is between one and eighty" do
    @panel.value= 'This is a big text to test a validate for the length of this property.'
    @panel.should be_valid
  end

  it "should not be an instance valid if the length of 'value' property is greater than eighty" do
    @panel.value= 'This is a big text to test a validate for the length of this property. If greater this instance is not valid.'
    @panel.should_not be_valid
  end

  it "should not be an instanve valid if the property 'ip' is nil" do
    @panel.ip= nil
    @panel.should_not be_valid
  end

  it "should not be an instance valid if the length of 'ip' property is equal zero" do
    @panel.ip= ''
    @panel.should_not be_valid
  end

  it "should be an instance valid if the length of 'ip' property is between one and fifteen" do
    @panel.ip= '255.255.255.255'
    @panel.should be_valid
  end

  it "should not be an instance valid if the length of 'ip' property is greater than fifteen" do
    @panel.ip= '255.255.255.255:1521'
    @panel.should_not be_valid
  end

  it "should not permit to create a new register with an existing 'value' registered" do
    @panel.save

    @panel_invalid = Panel.new( :value => "Panel 01", :ip => "10.32.1.22", :status => @status, :user => "1" )
    @panel_invalid.save.should == false
  end

  it "should permit to create a new register with an unexisting 'value' registered" do
    @panel.save

    @panel_valid = Panel.new( :value => "Panel 02", :ip => "10.32.1.2", :status => @status, :user => "1" )
    @panel_valid.save.should == true
  end

  it "should not permit to create a new register with an existing 'ip' registered" do
    @panel.save

    @panel_invalid = Panel.new( :value => "Panel 03", :ip => "10.32.1.22", :status => @status, :user => "1" )
    @panel_invalid.save.should == false
  end

  it "should permit to create a new register with an unexisting 'ip' registered" do
    @panel.save

    @panel_valid = Panel.new( :value => "Panel 04", :ip => "10.32.1.21", :status => @status, :user => "1" )
    @panel_valid.save.should == true
  end

  it "should not be an instanve valid if the property 'user' is nil" do
    @panel.user= nil
    @panel.should_not be_valid
  end

  it "should not be an instanve valid if the property 'user' is empty" do
    @panel.user= ''
    @panel.should_not be_valid
  end

  it "should not be an instanve valid if the property 'status' is nil" do
    @panel.status= nil
    @panel.should_not be_valid
  end

  it "Status should be the same value of property :status" do
    @panel.status.should eq( @status )
  end

end
