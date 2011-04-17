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

  it "call_history_type should not be nil" do
    @call_history.call_history_type= nil
    @call_history.should_not be_valid
  end

end
