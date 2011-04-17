require 'spec_helper'

describe Place do

  before( :each ) do
    @place = Factory.build(:place)
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

end
