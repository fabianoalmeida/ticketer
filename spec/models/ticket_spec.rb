require 'spec_helper'

describe Ticket do

  before( :each ) do
    @status = Status.new( :value => "Active", :user => "1" )
    @ticketType = TicketType.new( :value => "Priority", :acronym => "P", :user => "1", :status_id => 1, :status => @status )

    @statusTicket = StatusTicket.new( :value => "Opened", :acronym => "O", :user => "1" )

    pending "modify the form to obtain the sequence value and how to create an object Ticket"
    @ticket = Ticket.new( :value => @ticketType.acronym.to_s + "0001", :ticket_type => @ticketType, :status_ticket => @statusTicket )
  end

  it "can be an instance" do
    @ticket.should be_an_instance_of( Ticket )
  end

  it "can be save successfully" do
    @ticket.save.should == true
  end

  it "should have the same value of 'statusTicket.acronym' plus 'sequencial_number'" do
    @ticket.value.should eq( "P0001" )
  end

  it "the property 'value' should not have a differente value of 'P0001'" do
    @ticket.value.should_not eq( "P0002" )
  end

  it "the property 'ticket_type' should be the same of '@ticketType'" do
    @ticket.ticket_type.should eq( @ticketType )
  end

  it "the property 'ticket_type' should not be different of '@ticketType'" do
    @ticketTypeInvalid = TicketType.new( :value => "Consultation", :acronym => "C", :user => "1", :status_id => 1, :status => @status )
    @ticket.ticket_type.should_not eq( @ticketTypeInvalid )
  end

  it "the property 'status_ticket' should be the same of '@statusTicket'" do
    @ticket.status_ticket.should eq( @statusTicket )
  end

  it "the property 'status_ticket' should not be different of '@statusTicket'" do
    @statusTicketInvalid = StatusTicket.new( :value => "Consultation", :acronym => "C", :user => "1" )
    @ticket.status_ticket.should_not eq( @statusTicketInvalid )
  end
  
  it "should not be an instance valid if 'value' property is nil" do
    @ticket.value= nil
    @ticket.should_not be_valid
  end

  it "should not be an instance valid if the length of 'value' property is equal zero" do
    @ticket.value= ''
    @ticket.should_not be_valid
  end

  it "should be an instance valid if the length of 'value' property is between one and eighty" do
    @ticket.value= 'This is a big text to test a validate for the length of this property.'
    @ticket.should be_valid
  end

  it "should not be an instance valid if the length of 'value' property is greater than eighty" do
    @ticket.value= 'This is a big text to test a validate for the length of this property. If greater this instance is not valid.'
    @ticket.should_not be_valid
  end

  it "should not permit to create a new register with an existing 'value' registered" do
    @ticket.save

    @ticketInvalid = Ticket.new( :value => "P0001", :ticket_type => @ticketType, :status_ticket => @statusTicket )
    @ticketInvalid.save.should == false
  end

end
