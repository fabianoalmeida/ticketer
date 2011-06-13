require 'spec_helper'

describe TicketTypeGroup do

  before( :each ) do
    @ticket_type_group = Factory.build(:ticket_type_group)
    @ticket_type_group.places << stub_model(Place)
  end

  it "Should save Place normaly" do 
    @ticket_type_group.save.should be_true 
  end
  
  it "Should not be valid without Value" do 
    @ticket_type_group.value = nil
    @ticket_type_group.should have(1).errors_on(:value)
  end

  it "Should not be an instance valid if the length of 'value' property is equal zero" do
    @ticket_type_group.value= ''
    @ticket_type_group.should_not be_valid
  end

  it "should be an instance valid if the length of 'value' property is between one and eighty" do
    @ticket_type_group.value= 'This is a big text to test a validate for the length of this property.'
    @ticket_type_group.should be_valid
  end

  it "should not be an instance valid if the length of 'value' property is greater than eighty" do
    @ticket_type_group.value= 'This is a big text to test a validate for the length of this property. If greater this instance is not valid.'
    @ticket_type_group.should_not be_valid
  end

  it "should not permit to create a new register with an existing 'value' registered" do
    @ticket_type_group.save

    @ticket_type_invalid = Factory.build(:ticket_type_group, :value => @ticket_type_group.value)
    @ticket_type_invalid.save.should be_false 
    @ticket_type_upcase = Factory.build(:ticket_type_group, :value => @ticket_type_group.value.upcase)
    @ticket_type_upcase.save.should be_false 
    @ticket_type_downcase = Factory.build(:ticket_type_group, :value => @ticket_type_group.value.downcase)
    @ticket_type_downcase.save.should be_false 
  end

  it "Should not be valid without Status" do 
    @ticket_type_group.status = nil 
    @ticket_type_group.should have(1).errors_on(:status)
  end

end
