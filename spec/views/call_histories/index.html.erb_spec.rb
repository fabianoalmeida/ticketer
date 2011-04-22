require 'spec_helper'

describe "call_histories/index.html.erb" do
  before(:each) do
    assign(:call_histories, [
      mock_model(CallHistory,
        :ticket => stub_model(Ticket, :value => "ATT0001"),
        :wicket => stub_model(Wicket, :value => "Wicket 01"),
        :created_at => DateTime.now
      ),
      mock_model(CallHistory,
        :ticket => stub_model(Ticket, :value => "ATT0001"),
        :wicket => stub_model(Wicket, :value => "Wicket 01"),
        :created_at => DateTime.now
      )
    ])
  end

  it "renders a list of call_histories" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "ATT0001".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Wicket 01".to_s, :count => 2
  end
end
