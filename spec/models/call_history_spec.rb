require 'spec_helper'

describe CallHistory do
  
  before( :each ) do
    @call_history = Factory.build(:call_history)
  end

  it "can be save successfully" do
    @call_history.save.should be_true
  end

  it "ticket should not be nil" do
    @call_history.ticket= nil
    @call_history.should_not be_valid
  end

  it "wicket should not be nil" do
    @call_history.wicket= nil
    @call_history.should_not be_valid
  end

  context "Log and change state of ticket" do

    before :each do 
      @ticket = Factory(:ticket)
      @wicket = Factory(:wicket)
    end

    it "register a new occurrence " do 
      CallHistory.register(:ticket => @ticket, :wicket => @wicket).should be_true
      CallHistory.where(:ticket_id => @ticket.id).should have_at_least(1).items
      
    end
  end

end
