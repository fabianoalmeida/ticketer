require 'spec_helper'

describe "wickets/tickets.html.erb" do
  before(:each) do
    @place = assign(:place, stub_model(Place, :id => "1"))
    assign(:tickets, [
      stub_model(Ticket, :value => "P01" ),
      stub_model(Wicket, :value => "P01" )
    ])
    assign(:tickets_waiting,[
      stub_model(Ticket, :value => "P02" ),
      stub_model(Wicket, :value => "P02" )
    ])
  end

  it "renders a list of wickets" do
    render
    assert_select "table#tickets>tr>td", :text => "P01".to_s, :count => 2
    assert_select "table#tickets_waiting>tr>td", :text => "P02".to_s, :count => 0
  end
end
