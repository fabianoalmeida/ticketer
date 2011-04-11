require 'spec_helper'

describe Place do

  before( :each ) do
    @status = stub_model( Status, :value => "Active" )

    @local = stub_model( Local, :value => "Joaquim Neto" )

    @place = Place.new( :value => "Panel 01", :status => @status, :local => @local, :user => "1" )
  end

  pending "Finish this test like a real test."

end
