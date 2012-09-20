require 'spec_helper'

describe Place do

  before( :each ) do
    @place = FactoryGirl.build(:place)
  end

  it "Should save Place normaly" do 
    @place.save.should be_true 
  end
  
  it "Should not be valid without Value" do 
    @place.value = nil
    @place.should have(1).errors_on(:value)
  end

  it "Should not be valid without Status" do 
    @place.status = nil 
    @place.should have(1).errors_on(:status)
  end

  it "Should not be valid without Local" do 
    @place.local = nil 
    @place.should have(1).errors_on(:local)
  end

  it "Should not be valid without a list of Ticket Type Group" do 
    @place.ticket_type_groups.should_not be_empty
    @place.should have(:no).errors_on(:ticket_type_groups)
    @place.ticket_type_groups= []
    @place.should have(1).errors_on(:ticket_type_groups)
  end

end
