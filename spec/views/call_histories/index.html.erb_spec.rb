require 'spec_helper'

describe "call_histories/index.html.erb" do
  before(:each) do
    assign(:call_histories, [
      mock_model(CallHistory,
        :ticket_id => 1,
        :wicket_id => 1,
        :call_history_type_id => 1
      ),
      mock_model(CallHistory,
        :ticket_id => 1,
        :wicket_id => 1,
        :call_history_type_id => 1
      )
    ])
  end

  it "renders a list of call_histories" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 6
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 6
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 6
  end
end
