require 'spec_helper'

describe StatusTicket do

  before( :each ) do
    @statusTicket = StatusTicket.new( :value => "Opened", :acronym => "O", :user => "1" )
  end

  it "can be instantiated" do
    @statusTicket.should be_an_instance_of( StatusTicket )
  end

  it "can be saved successfully" do
    @statusTicket.save.should == true
  end

  it "should be an instance valid" do
    @statusTicket.should be_valid
  end
  
  it "should not be an instance valid if 'value' property is nil" do
    @statusTicket.value= nil
    @statusTicket.should_not be_valid
  end

  it "should not be an instance valid if 'acronym' property is nil" do
    @statusTicket.acronym= nil
    @statusTicket.should_not be_valid
  end
  
  it "should not be an instance valid if 'user' property is nil" do
    @statusTicket.user= nil
    @statusTicket.should_not be_valid
  end
  
  it "should not be an instance valid with length of 'acronym' equal zero" do
    @statusTicket.acronym= ''
    @statusTicket.should_not be_valid
  end
  
  it "should not be an instance valid with length of 'acronym' greater than one" do
    @statusTicket.acronym= 'OP'
    @statusTicket.should_not be_valid
  end
  
  it "should not be an instance valid with length of 'value' equal zero" do
    @statusTicket.value= ''
    @statusTicket.should_not be_valid
  end

  it "should be an instance valid with length of 'value' between one and eighty" do
    @statusTicket.value= 'This is a big text to test a validate for the length of this property.'
    @statusTicket.should be_valid
  end

  it "should not be an instance valid with length of 'value' greater than eighty" do
    @statusTicket.value= 'This is a big text to test a validate for the length of this property. If greater this instance is not valid.'
    @statusTicket.should_not be_valid
  end

  it "should not be create a register with an existing 'value' and 'acronym' registered" do
    @statusTicket.save

    @statusInvalid = StatusTicket.new( :value => "Opened", :acronym => "O", :user => "1" )
    @statusInvalid.save.should == false
  end

  it "should not be create a register with an existing 'value' registered" do
    @statusTicket.save

    @statusInvalid = StatusTicket.new( :value => "Opened", :acronym => "P", :user => "1" )
    @statusInvalid.save.should == false
  end

  it "should not be create a register with an existing 'acronym' registered" do
    @statusTicket.save

    @statusInvalid = StatusTicket.new( :value => "Openeds", :acronym => "O", :user => "1" )
    @statusInvalid.save.should == false
  end

end
