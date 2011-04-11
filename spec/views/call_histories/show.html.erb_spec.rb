require 'spec_helper'

describe "call_histories/show.html.erb" do
  before(:each) do
    @call_history = assign(:call_history, mock_model(CallHistory,
      :ticket_id => 1,
      :wicket_id => 1,
      :call_history_type_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
  end
end
