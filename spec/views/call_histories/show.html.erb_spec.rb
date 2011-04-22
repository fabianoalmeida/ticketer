require 'spec_helper'

describe "call_histories/show.html.erb" do
  before(:each) do
    @call_history = assign(:call_history, mock_model(CallHistory,
      :ticket => stub_model(Ticket, :value => "ATT0001"),
      :wicket => stub_model(Wicket, :value => "Wicket 01")
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/ATT0001/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Wicket 01/)
  end
end
