require 'spec_helper'

describe Ticket do

  before( :each ) do

    # modify the form to obtain the sequence value and how to create an object Ticket
    @status_ticket = stub_model(StatusTicket)
    @ticket = Factory.build(:ticket, :status_ticket => @status_ticket)
  end

  it "can be save successfully" do
    @ticket.save.should == true
  end

  it "should be an instance valid if the length of 'value' property is between one and eighty" do
    @ticket.value= 'This is a big text to test a validate for the length of this property.'
    @ticket.should be_valid
  end

  it "Should initialize with open state" do 
    @ticket.opened?.should be_true
  end

  it "Should allow to change from opened state to any other than called " do

    @ticket.cancel.should be_false
    @ticket.recall.should be_false 
    @ticket.reopen.should be_false 
    @ticket.pending.should be_false
    @ticket.call.should be_true

  end

  it "Should allow to change from called state only to pending or the same" do 

    @ticket.call.should be_true
    @ticket.reopen.should be_false
    @ticket.cancel.should be_false
    @ticket.recall.should be_true
    @ticket.pending.should be_true
    
  end 
    
  it "Should allow to change from pending only to canceled or opened" do 

    @ticket.call.should be_true 
    @ticket.pending.should be_true
    @ticket.call.should be_false
    @ticket.recall.should be_false
    @ticket.reopen.should be_true 
    #Redo state to pending to test cancel state
    @ticket.call.should be_true 
    @ticket.pending.should be_true
    @ticket.cancel.should be_true

  end

  it "Should not allow to change from canceled to any other" do 

    @ticket.call.should be_true 
    @ticket.pending.should be_true
    @ticket.cancel.should be_true
    @ticket.call.should be_false
    @ticket.recall.should be_false
    @ticket.reopen.should be_false
    @ticket.pending.should be_false
    
  end

  #pending to think about it how to test this one
  it "Should get the next ticket to be called"

end
