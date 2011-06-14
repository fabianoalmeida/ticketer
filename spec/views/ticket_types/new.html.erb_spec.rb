require 'spec_helper'

describe "ticket_types/new.html.erb" do
  before(:each) do
    @ticket_type_group = assign(:ticket_type_group, stub_model(TicketTypeGroup, :id => "1"))
    assign(:ticket_type, stub_model(TicketType,
      :value => "MyString",
      :acronym => "MyString",
      :user => "MyString",
      :status => stub_model(Status, :value => "Active")
    ).as_new_record)
  end

  it "renders new ticket_type form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => ticket_type_group_ticket_types_path(@ticket_type_group), :method => "post" do
      assert_select "input#ticket_type_value", :name => "ticket_type[value]"
      assert_select "input#ticket_type_acronym", :name => "ticket_type[acronym]"
      #assert_select "input#ticket_type_status", :name => "ticket_type[status]"
    end
  end
end
