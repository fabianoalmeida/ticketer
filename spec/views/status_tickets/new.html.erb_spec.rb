require 'spec_helper'

describe "status_tickets/new.html.erb" do
  before(:each) do
    assign(:status_ticket, stub_model(StatusTicket,
      :value => "MyString",
      :acronym => "MyString",
      :user_id => ""
    ).as_new_record)
  end

  it "renders new status_ticket form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => status_tickets_path, :method => "post" do
      assert_select "input#status_ticket_value", :name => "status_ticket[value]"
      assert_select "input#status_ticket_acronym", :name => "status_ticket[acronym]"
      assert_select "input#status_ticket_user_id", :name => "status_ticket[user_id]"
    end
  end
end
