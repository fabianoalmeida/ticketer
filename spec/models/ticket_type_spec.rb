require 'spec_helper'

describe TicketType do

  before ( :each ) do
    @ticket_type = Factory.build(:ticket_type)
  end

  it "should be an instance valid" do
    @ticket_type.should be_valid
  end

  it "should not be an instance valid if the 'value' property is nil" do
    @ticket_type.value= nil
    @ticket_type.should_not be_valid
  end

  it "should not be an instance valid if the length of 'value' property is equal zero" do
    @ticket_type.value= ''
    @ticket_type.should_not be_valid
  end

  it "should be an instance valid if the length of 'value' property is between one and eighty" do
    @ticket_type.value= 'This is a big text to test a validate for the length of this property.'
    @ticket_type.should be_valid
  end

  it "should not be an instance valid if the length of 'value' property is greater than eighty" do
    @ticket_type.value= 'This is a big text to test a validate for the length of this property. If greater this instance is not valid.'
    @ticket_type.should_not be_valid
  end

  it "should not permit to create a new register with an existing 'value' registered" do
    @ticket_type.save

    @ticket_typeInvalid = Factory.build(:ticket_type, :value => @ticket_type.value, :ticket_type_group => @ticket_type.ticket_type_group)
    @ticket_typeInvalid.save.should be_false
  end

  it "should permit to create a new register with an existing 'value' registered but with different 'ticket_type_group.value'" do
    @ticket_type.save
    ticket_type_group = Factory.build(:ticket_type_group, :value => "Xpto")

    @ticket_typeInvalid = Factory.build(:ticket_type, :value => @ticket_type.value, :ticket_type_group => ticket_type_group)
    @ticket_typeInvalid.save.should be_true
  end

  it "should permit to create a new register with an unexisting 'value' registered" do
    @ticket_type.save.should == true
  end

  it "should not be an instance valid if the 'acronym' property is nil" do
    @ticket_type.acronym= nil
    @ticket_type.should_not be_valid
  end

  it "should not be an instance valid if the length of 'acronym' property is equal zero" do
    @ticket_type.acronym= ''
    @ticket_type.should_not be_valid
  end

  it "should not be an instance valid if the length of 'acronym' property is greatest than 3" do
    @ticket_type.acronym= 'PDRT'
    @ticket_type.should_not be_valid
  end

  it "should not permit to create a new register with an existing 'acronym' registered" do
    @ticket_type.save
    @ticket_typeInvalid = Factory.build(:ticket_type,
                                       :ticket_type_group => @ticket_type.ticket_type_group,
                                       :acronym => @ticket_type.acronym )
    @ticket_typeInvalid.save.should be_false
  end

  it "should not be an instance valid if the 'user' property is nil" do
    @ticket_type.user= nil
    @ticket_type.should_not be_valid
  end

  it "should not be an instance valid if the length of 'user' property is equal zero" do
    @ticket_type.user= ''
    @ticket_type.should_not be_valid
  end

  it "should not be an instance valid if the 'status' property is nil" do
    @ticket_type.status= nil
    @ticket_type.should_not be_valid
  end

  it "should not be an instance valid if have not a relationship with 'status' model" do
    @ticket_type.status= nil
    @ticket_type.should_not be_valid
  end

  it "should not be an instance valid if have not a relationship with 'ticket_type_group' model" do
    @ticket_type.ticket_type_group= nil
    @ticket_type.should have(1).errors_on(:ticket_type_group)
  end
end
