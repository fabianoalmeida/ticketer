require 'spec_helper'

describe "TicketTypes" do
  describe "GET /ticket_types" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get ticket_type_group_ticket_types_path(1)
      response.status.should be(200)
    end
  end
end
