require 'spec_helper'

describe "call_history_types/new.html.erb" do
  before(:each) do
    assign(:call_history_type, stub_model(CallHistoryType,
      :value => "MyString",
      :acronym => "MyString",
      :user => "MyString"
    ).as_new_record)
  end

  it "renders new call_history_type form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => call_history_types_path, :method => "post" do
      assert_select "input#call_history_type_value", :name => "call_history_type[value]"
      assert_select "input#call_history_type_acronym", :name => "call_history_type[acronym]"
    end
  end
end
