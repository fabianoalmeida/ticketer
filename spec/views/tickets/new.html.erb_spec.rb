require 'spec_helper'

describe "tickets/new.html.erb" do
  before(:each) do
    assign(:ticket, mock_model(Ticket,
      :value => "MyString",
      :ticket_type => stub_model(TicketType),
      :status_ticket => stub_model(StatusTicket),
      :place => stub_model(Place)
    ).as_new_record)
  end

  it "renders new ticket form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => tickets_path, :method => "post" do
      assert_select "input#ticket_value", :name => "ticket[value]"
      assert_select "input#ticket_ticket_type", :name => "ticket[ticket_type]"
    end
  end
end
