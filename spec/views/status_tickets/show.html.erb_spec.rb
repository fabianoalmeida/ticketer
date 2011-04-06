require 'spec_helper'

describe "status_tickets/show.html.erb" do
  before(:each) do
    @status_ticket = assign(:status_ticket, stub_model(StatusTicket,
      :value => "Value",
      :acronym => "Acronym",
      :user => ""
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Value/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Acronym/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
  end
end
