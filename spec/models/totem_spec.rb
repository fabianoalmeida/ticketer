require 'spec_helper'

describe Totem do

  before( :each ) do
    @status = stub_model( Status, :value => "Active" )
    
    @place = stub_model( Place )

    @totem = Totem.new( :value => "Totem 01", :ip => "10.32.1.22", :status => @status, :place => @place, :user => "1" )
  end

  it "can be save successfully" do
    @totem.save.should == true
  end

  it "should not be an instanve valid if the property 'value' is nil" do
    @totem.value= nil
    @totem.should_not be_valid( :value )
  end

  it "should not be an instance valid if the length of 'value' property is equal zero" do
    @totem.value= ''
    @totem.should_not be_valid( :value )
  end

  it "should be an instance valid if the length of 'value' property is between one and eighty" do
    @totem.value= 'This is a big text to test a validate for the length of this property.'
    @totem.should be_valid
  end

  it "should not be an instance valid if the length of 'value' property is greater than eighty" do
    @totem.value= 'This is a big text to test a validate for the length of this property. If greater this instance is not valid.'
    @totem.should_not be_valid
  end

  it "should not be an instanve valid if the property 'ip' is nil" do
    @totem.ip= nil
    @totem.should_not be_valid( :ip )
  end

  it "should not be an instance valid if the length of 'ip' property is equal zero" do
    @totem.ip= ''
    @totem.should_not be_valid( :ip )
  end

  it "should be an instance valid if the length of 'ip' property is between one and fifteen" do
    @totem.ip= "10.32.2.25"
    @totem.should be_valid
  end

  it "should not be an instance valid if the length of 'ip' property is greater than fifteen" do
    @totem.ip= '255.255.255.255:1521'
    @totem.should_not be_valid( :ip )
  end

  it "should not be an instance valid if the value of 'ip' property is not within the correct format" do
    @totem.ip= "32.2.25"
    @totem.should_not be_valid( :ip )
  end

  it "should not permit to create a new register with an existing 'value' registered" do
    @totem.save

    @totem_invalid = Totem.new( :value => "Totem 01", :ip => "10.32.1.22", :status => @status, :place => @place, :user => "1" )
    @totem_invalid.save 
    @totem_invalid.errors[ :value ].should == [ "already exists!" ]
  end

  it "should not permit to create a new register with an existing 'value' registered even that has a different case sensitive" do
    @totem.save

    @totem_invalid = Totem.new( :value => "ToTeM 01", :ip => "10.32.1.22", :status => @status, :place => @place, :user => "1" )
    @totem_invalid.save 
    @totem_invalid.errors[ :value ].should == [ "already exists!" ]
  end

  it "should permit to create a new register with an unexisting 'value' registered" do
    @totem.save

    @totem_valid = Totem.new( :value => "Totem 02", :ip => "10.32.1.2", :status => @status, :place => @place, :user => "1" )
    @totem_valid.save.should == true
  end

  it "should not permit to create a new register with an existing 'ip' registered" do
    @totem.save

    @totem_invalid = Totem.new( :value => "Totem 03", :ip => "10.32.1.22", :status => @status, :place => @place, :user => "1" )
    @totem_invalid.save
    @totem_invalid.errors[ :ip ].should == [ "already exists!" ]
  end

  it "should permit to create a new register with an unexisting 'ip' registered" do
    @totem.save

    @totem_valid = Totem.new( :value => "Totem 04", :ip => "10.32.1.20", :status => @status, :place => @place, :user => "1" )
    @totem_valid.save.should == true
  end

  it "should not be an instance valid if the property 'user' is nil" do
    @totem.user= nil
    @totem.should_not be_valid
  end

  it "should not be an instanve valid if the property 'user' is empty" do
    @totem.user= ''
    @totem.should_not be_valid
  end

  it "should not be an instance valid if the property 'status' is nil" do
    @totem.status= nil
    @totem.should_not be_valid
  end

  it "Status should be the same value of property :status" do
    @totem.status.should eq( @status )
  end

  it "should not be an instance valid if the property 'place' is nil" do
    @totem.place= nil
    @totem.should_not be_valid
  end

  it "Status should be the same value of property :place" do
    @totem.place.should eq( @place )
  end

end
