require 'spec_helper'

describe "panels/tickets.html.erb" do 

  before(:each) do 
    @tickets = []
    @tickets << stub_model(Ticket, 
                 :value => "value",
                 :ticket_type => stub_model(TicketType, :value => "pref"), 
                 :updated_at => DateTime.now
                 )
    @tickets << stub_model(Ticket, 
                 :value => "value",
                 :ticket_type => stub_model(TicketType, :value => "pref"),
                 :updated_at => DateTime.now 
                 )
     @tickets.each do |ticket|
       ticket.stub_chain(:wickets, :last, :guidance_right?).and_return(true)
       ticket.stub_chain(:wickets, :last, :guidance_left?).and_return(false)
     end
  end
  
  it "renders a list of tickets for the place" do
    render 

    assert_select "tr>td", :text => "value".to_s, :count => 2
      
  end
end
    
