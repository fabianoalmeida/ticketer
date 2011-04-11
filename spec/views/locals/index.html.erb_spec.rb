require 'spec_helper'

describe "locals/index.html.erb" do
  before(:each) do
    assign(:locals, [
      stub_model(Local,
        :value => "Value",
        :status_id => 1,
        :user => "User"
      ),
      stub_model(Local,
        :value => "Value",
        :status_id => 1,
        :user => "User"
      )
    ])
  end

  it "renders a list of locals" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Value".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "User".to_s, :count => 2
  end
end
