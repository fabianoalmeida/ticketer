require 'spec_helper'

describe "panels/tickets.html.erb" do 

  before(:each) do
    assign(:place, stub_model(Place, :value => "Yahoo"));
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
       ticket.stub_chain(:wickets, :last, :value).and_return("value")
     end
  end
  
  it "renders a list of tickets for the place" do
    render 

    #assert_select "div", :text => "value".to_s, :count => 1
      
  end
end
    
