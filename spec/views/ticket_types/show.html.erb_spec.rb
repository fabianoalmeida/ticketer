require 'spec_helper'

describe "ticket_types/show.html.erb" do
  before(:each) do
    @ticket_type = assign(:ticket_type, stub_model(TicketType,
      :value => "Value",
      :acronym => "Acronym",
      :user => "User"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Value/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Acronym/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/User/)
  end
end
