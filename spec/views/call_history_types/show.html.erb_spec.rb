require 'spec_helper'

describe "call_history_types/show.html.erb" do
  before(:each) do
    @call_history_type = assign(:call_history_type, stub_model(CallHistoryType,
      :value => "Value",
      :acronym => "Acronym",
      :user => "User"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Value/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Acronym/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/User/)
  end
end
