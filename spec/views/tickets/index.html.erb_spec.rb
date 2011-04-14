require 'spec_helper'

describe "tickets/index.html.erb" do
  before(:each) do
    assign(:tickets, [
      mock_model(Ticket,
        :value => "Value",
        :ticket_type => stub_model(TicketType, :value => "Preferencial"),
        :status_ticket => stub_model(StatusTicket, :value => "Called"),
        :place => stub_model(Place)

      ),
      mock_model(Ticket,
        :value => "Value",
        :ticket_type => stub_model(TicketType, :value => "Preferencial"),
        :status_ticket => stub_model(StatusTicket, :value => "Called"),
        :place => stub_model(Place)
      )
    ])
  end

  it "renders a list of tickets" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Value".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Preferencial".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Called".to_s, :count => 2
  end
end
