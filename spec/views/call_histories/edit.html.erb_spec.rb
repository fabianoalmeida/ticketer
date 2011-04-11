require 'spec_helper'

describe "call_histories/edit.html.erb" do
  before(:each) do
    @call_history = assign(:call_history, mock_model(CallHistory,
      :ticket_id => 1,
      :wicket_id => 1,
      :call_history_type_id => 1
    ))
  end

  it "renders the edit call_history form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => call_histories_path(@call_history), :method => "post" do
      assert_select "input#call_history_ticket_id", :name => "call_history[ticket_id]"
      assert_select "input#call_history_wicket_id", :name => "call_history[wicket_id]"
      assert_select "input#call_history_call_history_type_id", :name => "call_history[call_history_type_id]"
    end
  end
end
