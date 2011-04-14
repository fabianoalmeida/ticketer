require 'spec_helper'

describe "ticket_types/edit.html.erb" do
  before(:each) do
    @ticket_type = assign(:ticket_type, stub_model(TicketType,
      :value => "MyString",
      :acronym => "MyString",
      :user => "MyString",
      :status => stub_model(Status, :value=> "Active")
    ))
  end

  it "renders the edit ticket_type form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => ticket_types_path(@ticket_type), :method => "post" do
      assert_select "input#ticket_type_value", :name => "ticket_type[value]"
      assert_select "input#ticket_type_acronym", :name => "ticket_type[acronym]"
      #assert_select "input#ticket_type_status_id", :name => "ticket_type[status_id]"
    end
  end
end
