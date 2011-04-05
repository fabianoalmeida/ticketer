require 'spec_helper'

describe "StatusTickets" do
  describe "GET /status_tickets" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get status_tickets_path
      response.status.should be(200)
    end
  end
end
