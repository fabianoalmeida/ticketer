require 'spec_helper'

describe "ticket_types/new.html.erb" do
  before(:each) do
    assign(:ticket_type, stub_model(TicketType,
      :value => "MyString",
      :acronym => "MyString",
      :user => "MyString"
    ).as_new_record)
  end

  it "renders new ticket_type form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => ticket_types_path, :method => "post" do
      assert_select "input#ticket_type_value", :name => "ticket_type[value]"
      assert_select "input#ticket_type_acronym", :name => "ticket_type[acronym]"
      assert_select "input#ticket_type_user", :name => "ticket_type[user]"
    end
  end
end
