require 'spec_helper'

describe "call_history_types/index.html.erb" do
  before(:each) do
    assign(:call_history_types, [
      stub_model(CallHistoryType,
        :value => "Value",
        :acronym => "Acronym",
        :user => "User"
      ),
      stub_model(CallHistoryType,
        :value => "Value",
        :acronym => "Acronym",
        :user => "User"
      )
    ])
  end

  it "renders a list of call_history_types" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Value".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Acronym".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "User".to_s, :count => 2
  end
end
