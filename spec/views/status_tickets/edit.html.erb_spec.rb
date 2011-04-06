require 'spec_helper'

describe "status_tickets/edit.html.erb" do
  before(:each) do
    @status_ticket = assign(:status_ticket, stub_model(StatusTicket,
      :value => "MyString",
      :acronym => "MyString",
      :user => ""
    ))
  end

  it "renders the edit status_ticket form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => status_tickets_path(@status_ticket), :method => "post" do
      assert_select "input#status_ticket_value", :name => "status_ticket[value]"
      assert_select "input#status_ticket_acronym", :name => "status_ticket[acronym]"
    end
  end
end
