require 'spec_helper'

describe "panels/tickets.html.erb" do 

  before(:each) do 
     assign(:tickets, [
       stub_model(Ticket, 
                 :value => "value",
                 :ticket_type => stub_model(TicketType, :value => "pref"), 
                 :updated_at => DateTime.now
                 ),
      stub_model(Ticket, 
                 :value => "value",
                 :ticket_type => stub_model(TicketType, :value => "pref"),
                 :updated_at => DateTime.now 
                 )
     ]) 
  end
  
  it "renders a list of tickets for the place" do
    render 

    assert_select "tr>td", :text => "value".to_s, :count => 2
    assert_select "tr>td", :text => "pref".to_s, :count => 2 
      
  end
end
    
