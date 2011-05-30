require 'spec_helper'

describe "wickets/tickets.html.erb" do
  before(:each) do
    @place = assign(:place, stub_model(Place, :id => "1"))
    assign(:tickets_type, [
      stub_model(TicketType, :value => '01'),
      stub_model(TicketType, :value => '02')
    ])
    assign(:tickets, [
      stub_model(Ticket, :value => "P01", :updated_at => DateTime.now),
      stub_model(Ticket, :value => "P01", :updated_at => DateTime.now)
    ])
    assign(:tickets_waiting,[
      stub_model(Ticket, :value => "P02", :updated_at => DateTime.now),
      stub_model(Ticket, :value => "P02", :updated_at => DateTime.now)
    ])
    assign(:tickets_called,[
      stub_model(Ticket, :value => "P02", :updated_at => DateTime.now),
      stub_model(Ticket, :value => "P02", :updated_at => DateTime.now)
    ])
  end

  it "renders a list of wickets" do
    render
    assert_select "div#tickets_available>ul>li>span", :text => "P01", :count => 2
    assert_select "div#tickets_waiting>ul>li>span", :text => "P02", :count => 2
    assert_select "div#tickets_called>ul>li>span", :text => "P02", :count => 2
  end
end
