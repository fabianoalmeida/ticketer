require 'spec_helper'

describe "call_history_types/edit.html.erb" do
  before(:each) do
    @call_history_type = assign(:call_history_type, stub_model(CallHistoryType,
      :value => "MyString",
      :acronym => "MyString",
      :user => "MyString"
    ))
  end

  it "renders the edit call_history_type form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => call_history_types_path(@call_history_type), :method => "post" do
      assert_select "input#call_history_type_value", :name => "call_history_type[value]"
      assert_select "input#call_history_type_acronym", :name => "call_history_type[acronym]"
      assert_select "input#call_history_type_user", :name => "call_history_type[user]"
    end
  end
end
