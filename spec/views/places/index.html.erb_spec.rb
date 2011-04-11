require 'spec_helper'

describe "places/index.html.erb" do
  before(:each) do
    assign(:places, [
      stub_model(Place,
        :value => "Value",
        :user => "User",
        :status_id => 1
      ),
      stub_model(Place,
        :value => "Value",
        :user => "User",
        :status_id => 1
      )
    ])
  end

  it "renders a list of places" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Value".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "User".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
