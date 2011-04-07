require 'spec_helper'

describe "tickets/index.html.erb" do
  before(:each) do
    assign(:tickets, [
      stub_model(Ticket,
        :value => "Value",
        :ticket_type_id => 1,
        :status_ticket_id => 1
      ),
      stub_model(Ticket,
        :value => "Value",
        :ticket_type_id => 1,
        :status_ticket_id => 1
      )
    ])
  end

  it "renders a list of tickets" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Value".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 4
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 4
  end
end
