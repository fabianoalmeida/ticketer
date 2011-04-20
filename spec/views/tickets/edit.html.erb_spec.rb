require 'spec_helper'

describe "tickets/edit.html.erb" do
  before(:each) do
    @ticket = assign(:ticket, mock_model(Ticket,
      :value => "MyString",
      :ticket_type => stub_model(TicketType, :value => "Normal"),
      :status => stub_model(Status, :value => "value"),
      :place => stub_model(Place, :value => "Place 01")
    ))
  end

  it "renders the edit ticket form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => tickets_path(@ticket), :method => "post" do
      assert_select "input#ticket_value", :name => "ticket[value]"
      assert_select "input#ticket_ticket_type", :name => "ticket[ticket_type]"
      #assert_select "input#ticket_status_ticket_id", :name => "ticket[status_ticket_id]"
    end
  end
end
