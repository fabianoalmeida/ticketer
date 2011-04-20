require 'spec_helper'

describe "status_tickets/index.html.erb" do
  before(:each) do
    assign(:status_tickets, [
      stub_model(StatusTicket,
        :value => "Value",
        :acronym => "Acronym",
        :user => "",
        :created_at => DateTime.now
      ),
      stub_model(StatusTicket,
        :value => "Value",
        :acronym => "Acronym",
        :user => "",
        :created_at => DateTime.now
      )
    ])
  end

  it "renders a list of status_tickets" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Value".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Acronym".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
