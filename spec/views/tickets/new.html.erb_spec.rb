require 'spec_helper'

describe "tickets/new.html.erb" do
  before(:each) do
    assign(:ticket, stub_model(Ticket,
      :value => "MyString",
      :ticket_type_id => 1,
      :status_ticket_id => 1
    ).as_new_record)
  end

  it "renders new ticket form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => tickets_path, :method => "post" do
      assert_select "input#ticket_value", :name => "ticket[value]"
      assert_select "input#ticket_ticket_type_id", :name => "ticket[ticket_type_id]"
      assert_select "input#ticket_status_ticket_id", :name => "ticket[status_ticket_id]"
    end
  end
end
