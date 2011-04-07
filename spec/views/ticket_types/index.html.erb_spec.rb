require 'spec_helper'

describe "ticket_types/index.html.erb" do
  before(:each) do
    assign(:ticket_types, [
      stub_model(TicketType,
        :value => "Value",
        :acronym => "Acronym",
        :user => "User",
        :status_id => 1
      ),
      stub_model(TicketType,
        :value => "Value",
        :acronym => "Acronym",
        :user => "User",
        :status_id => 1
      )
    ])
  end

  it "renders a list of ticket_types" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Value".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Acronym".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "User".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
