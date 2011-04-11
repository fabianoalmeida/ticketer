require 'spec_helper'

describe "call_histories/new.html.erb" do
  before(:each) do
    assign(:call_history, mock_model(CallHistory,
      :ticket_id => 1,
      :wicket_id => 1,
      :call_history_type_id => 1
    ).as_new_record)
  end

  it "renders new call_history form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => call_histories_path, :method => "post" do
      assert_select "input#call_history_ticket_id", :name => "call_history[ticket_id]"
      assert_select "input#call_history_wicket_id", :name => "call_history[wicket_id]"
      assert_select "input#call_history_call_history_type_id", :name => "call_history[call_history_type_id]"
    end
  end
end
