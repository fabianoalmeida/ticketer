require 'spec_helper'

describe CallHistory do
  
  before( :each ) do
    @ticket = stub_model( Ticket, :value => "P0001" )
    @wicket = stub_model( Wicket, :value => "Wicket 01" )
    @call_history_type = stub_model( CallHistoryType, :value => "Called" )

    @call_history = CallHistory.new( :ticket => @ticket, :wicket => @wicket, :call_history_type => @call_history_type )
  end

  it "can be an instance" do
    @call_history.should be_an_instance_of( CallHistory )
  end

  it "can be save successfully" do
    @call_history.save.should == true
  end

  it "ticket should not be nil" do
    @call_history.ticket= nil
    @call_history.should_not be_valid
  end

  it "wicket should not be nil" do
    @call_history.wicket= nil
    @call_history.should_not be_valid
  end

  it "call_history_type should not be nil" do
    @call_history.call_history_type= nil
    @call_history.should_not be_valid
  end

  it "Ticket should be equal to :ticket" do
    @call_history.ticket.should eq( @ticket )
  end

  it "Wicket should be equal to :wicket" do
    @call_history.wicket.should eq( @wicket )
  end

  it "CallHistoryType should be equal to :call_history_type" do
    @call_history.call_history_type.should eq( @call_history_type )
  end

end
