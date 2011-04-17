require 'spec_helper'

describe Ticket do

  before( :each ) do

    # modify the form to obtain the sequence value and how to create an object Ticket
    @status_ticket = stub_model(StatusTicket)
    @ticket = Factory.build(:ticket, :status_ticket=> @status_ticket)
  end

  it "can be save successfully" do
    @ticket.save.should == true
  end

  it "should have the same value of 'statusTicket.acronym' plus 'sequencial_number'" do
    pending "Should implement the Ticket Generator"
    @ticket.value.should eq( "P0001" )
  end

  it "the property 'value' should not have a differente value of 'P0001'" do
    pending "Should implement the Ticket Generator"
    @ticket.value.should_not eq( "P0002" )
  end

  it "the property 'ticket_type' should not be different of '@ticketType'" do
    pending "This no make sense to me. Can't I change the ticket_type from ticket ?"

    @ticketTypeInvalid = TicketType.new( :value => "Consultation", :acronym => "C", :user => "1", :status_id => 1, :status => @status )
    @ticket.ticket_type.should_not eq( @ticketTypeInvalid )
  end
    
  it "should not be an instance valid if 'value' property is nil" do
    pending "This not make sense, if is this gerneted after 'save' why this should be validated ?" 
    @ticket.value= nil
    @ticket.should_not be_valid
  end

  it "should not be an instance valid if the length of 'value' property is equal zero" do
    pending "This not make sense, if is this gerneted after 'save' why this should be validated ?" 
    @ticket.value= ''
    @ticket.should_not be_valid
  end

  it "should be an instance valid if the length of 'value' property is between one and eighty" do
    @ticket.value= 'This is a big text to test a validate for the length of this property.'
    @ticket.should be_valid
  end

  it "should not be an instance valid if the length of 'value' property is greater than eighty" do
    pending "This not make sense, if is this gerneted after 'save' why this should be validated ?" 
    @ticket.value= 'This is a big text to test a validate for the length of this property. If greater this instance is not valid.'
    @ticket.should_not be_valid
  end

  it "should not permit to create a new register with an existing 'value' registered" do
    pending "This not make sense, if is this gerneted after 'save' why this should be validated ?" 
    @ticket.save
    @ticketInvalid = Factory.build(:ticket, :value => @ticket.value)
    @ticketInvalid.save.should be_false  
  end

end
