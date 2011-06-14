require 'spec_helper'

describe "ticket_types/index.html.erb" do
  before(:each) do
    @ticket_type_group = stub_model(TicketTypeGroup, :id => "1")
    status = stub_model(Status, :value => "Test")
    assign(:ticket_types, [
      stub_model(TicketType,
        :value => "Value",
        :acronym => "Acronym",
        :user => "User",
        :status => status,
        :ticket_type_group => @ticket_type_group
      ),
      stub_model(TicketType,
        :value => "Value",
        :acronym => "Acronym",
        :user => "User",
        :status => status,
        :ticket_type_group => @ticket_type_group
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
    assert_select "tr>td", :text => "Value".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "User".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Test".to_s, :count => 2
  end
end
