require 'spec_helper'

describe Wicket do

  before( :each ) do
    @place = stub_model( Place )
    @status = stub_model( Status )
    @guidance = stub_model( Guidance )
    @wicket = Wicket.new( :value => "Wicket 01", :user => "1", :guidance => @guidance, :status => @status  , :place => @place)
  end

  it "can be an instance" do
    @wicket.should be_an_instance_of( Wicket )
  end

  it "can be save successfully" do
    @wicket.save.should == true
  end

  it "should be an instance valid" do
    @wicket.should be_valid
  end

  it "should not be an instance valid if the 'value' property is nil" do
    @wicket.value= nil
    @wicket.should_not be_valid
  end

  it "should not be an instance valid if the length of 'value' property is equal zero" do
    @wicket.value= ''
    @wicket.should_not be_valid
  end

  it "should be an instance valid if the length of 'value' property is between one and eighty" do
    @wicket.value= 'This is a big text to test a validate for the length of this property.'
    @wicket.should be_valid
  end

  it "should not be an instance valid if the length of 'value' property is greater than eighty" do
    @wicket.value= 'This is a big text to test a validate for the length of this property. If greater this instance is not valid.'
    @wicket.should_not be_valid
  end

  it "should not permit to create a new register with an existing 'value' registered" do
    @wicket.save

    @wicketInvalid = Wicket.new( :value => "Wicket 01", :user => "1", :guidance => @guidance, :status => @status, :place => @place)
    @wicketInvalid.save.should == false
  end

  it "should permit to create a new register with an existing 'value' registered" do
    @wicket.save

    @wicketValid = Wicket.new( :value => "Wicket 02", :user => "1", :guidance => @guidance, :status => @status, :place => @place)
    @wicketValid.save.should == true
  end
  
  it "should not be an instance valid if the 'user' property is nil" do
    @wicket.user= nil
    @wicket.should_not be_valid
  end
  
  it "should not be an instance valid if the length of 'user' property is equal zero" do
    @wicket.user= ''
    @wicket.should_not be_valid
  end
  
  it "should not be an instance valid if the 'guidance_id' property is nil" do
    @wicket.guidance= nil
    @wicket.should_not be_valid
  end
  
  it "should not be an instance valid if the 'status_id' property is nil" do
    @wicket.status= nil
    @wicket.should_not be_valid
  end
  
end
