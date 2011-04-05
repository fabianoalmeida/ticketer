require 'spec_helper'

describe StatusTicket do

  before( :each ) do
    @statusTicket = StatusTicket.new( :value => "Opened", :acronym => "O", :user_id => 1 )
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

end
