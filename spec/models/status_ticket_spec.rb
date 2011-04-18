require 'spec_helper'

describe StatusTicket do

  before( :each ) do
    @statusTicket = Factory.build(:status_ticket)
  end

  it "can be saved successfully" do
    @statusTicket.save.should be_true
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
    @statusTicket.acronym= 'OPIR'
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
    @statusInvalid = Factory.build(:status_ticket, :value => @statusTicket.value, :acronym => @statusTicket.acronym)
    @statusInvalid.save.should be_false
  end

  it "should not be create a register with an existing 'value' registered" do
    @statusTicket.save

    @statusInvalid = Factory.build(:status_ticket, :value => @statusTicket.value)
    @statusInvalid.save.should be_false

  end

  it "should not be create a register with an existing 'acronym' registered" do
    @statusTicket.save

    @statusInvalid = Factory.build(:status_ticket, :acronym => @statusTicket.acronym)
    @statusInvalid.save.should be_false
  end

end
