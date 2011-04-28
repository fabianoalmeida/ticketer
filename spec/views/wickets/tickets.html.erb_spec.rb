require 'spec_helper'

describe "wickets/tickets.html.erb" do
  before(:each) do
    @place = assign(:place, stub_model(Place, :id => "1"))
    assign(:tickets, [
      stub_model(Ticket, :value => "P01", :updated_at => DateTime.now),
      stub_model(Ticket, :value => "P01", :updated_at => DateTime.now)
    ])
    assign(:tickets_waiting,[
      stub_model(CallHistory, 
                 :ticket => stub_model(Ticket, :value => "P02", :updated_at => DateTime.now)),
      stub_model(CallHistory, 
                 :ticket => stub_model(Ticket, :value => "P02", :updated_at => DateTime.now)),
    ])
    assign(:tickets_called,[
      stub_model(CallHistory, 
                 :ticket => stub_model(Ticket, :value => "P02", :updated_at => DateTime.now)),
      stub_model(CallHistory, 
                 :ticket => stub_model(Ticket, :value => "P02", :updated_at => DateTime.now)),
    ])
  end

  it "renders a list of wickets" do
    render
    assert_select "table#tickets>tr>td", :text => "P01".to_s, :count => 2
    assert_select "table#tickets_waiting>tr>td", :text => "P02".to_s, :count => 2
    assert_select "table#tickets_called>tr>td", :text => "P02".to_s, :count => 2
  end
end
