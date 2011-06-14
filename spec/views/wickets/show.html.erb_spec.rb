require 'spec_helper'

describe "wickets/show.html.erb" do
  before(:each) do
    @ticket_type_group = assign(:ticket_type_group, stub_model(TicketTypeGroup, :value => "Group"))
    @place = assign(:place, stub_model(Place, :id => "1"))
    @wicket = assign(:wicket, stub_model(Wicket,
      :value => "Value",
      :guidance => true,
      :status => stub_model(Status, :value => "value"),
      :user => "User",
      :place => @place,
      :ticket_type_group => @ticket_type_group
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Value/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/value/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/value/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/value/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/User/)
  end
end
