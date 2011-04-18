require 'spec_helper'

describe TicketType do

  before ( :each ) do
    @ticketType = Factory.build(:ticket_type)
  end

  it "should be an instance valid" do
    @ticketType.should be_valid
  end

  it "should not be an instance valid if the 'value' property is nil" do
    @ticketType.value= nil
    @ticketType.should_not be_valid
  end

  it "should not be an instance valid if the length of 'value' property is equal zero" do
    @ticketType.value= ''
    @ticketType.should_not be_valid
  end

  it "should be an instance valid if the length of 'value' property is between one and eighty" do
    @ticketType.value= 'This is a big text to test a validate for the length of this property.'
    @ticketType.should be_valid
  end

  it "should not be an instance valid if the length of 'value' property is greater than eighty" do
    @ticketType.value= 'This is a big text to test a validate for the length of this property. If greater this instance is not valid.'
    @ticketType.should_not be_valid
  end

  it "should not permit to create a new register with an existing 'value' registered" do
    @ticketType.save

    @ticketTypeInvalid = Factory.build(:ticket_type, :value => @ticketType.value)
    @ticketTypeInvalid.save.should be_false 
  end

  it "should permit to create a new register with an unexisting 'value' registered" do
    @ticketType.save.should == true
  end

  it "should not be an instance valid if the 'acronym' property is nil" do
    @ticketType.acronym= nil
    @ticketType.should_not be_valid
  end
  
  it "should not be an instance valid if the length of 'acronym' property is equal zero" do
    @ticketType.acronym= ''
    @ticketType.should_not be_valid
  end

  it "should not be an instance valid if the length of 'acronym' property is greatest than 3" do
    @ticketType.acronym= 'PDRT'
    @ticketType.should_not be_valid
  end

  it "should not permit to create a new register with an existing 'acronym' registered" do
    @ticketType.save
    @ticketTypeInvalid = Factory.build(:ticket_type, :acronym => @ticketType.acronym )
    @ticketTypeInvalid.save.should be_false
  end

  it "should not be an instance valid if the 'user' property is nil" do
    @ticketType.user= nil
    @ticketType.should_not be_valid
  end
  
  it "should not be an instance valid if the length of 'user' property is equal zero" do
    @ticketType.user= ''
    @ticketType.should_not be_valid
  end
  
  it "should not be an instance valid if the 'status' property is nil" do
    @ticketType.status= nil
    @ticketType.should_not be_valid
  end
  
  it "should not be an instance valid if have not a relationship with 'status' model" do
    pending "need ask a question"
    @ticketType.status= nil
    @ticketType.should_not be_valid
  end

end
