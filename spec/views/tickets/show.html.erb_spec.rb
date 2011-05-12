require 'spec_helper'

describe "tickets/show.html.erb" do
  before(:each) do
    @ticket = assign(:ticket, mock_model(Ticket,
      :value => "Value",
      :created_at => DateTime.now,
      :updated_at => DateTime.now,
      :ticket_type => stub_model(TicketType, :value => "P0001"),
      :status_ticket => stub_model(StatusTicket, :value => "Called"),
      :place_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Value/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/P0001/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Called/)
  end
end
