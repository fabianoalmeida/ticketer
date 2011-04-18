require 'spec_helper'

describe "places/index.html.erb" do
  before(:each) do
    @place = assign(:place, stub_model(Place, :id => "1"))
    assign(:places, [
      stub_model(Place,
        :value => "Value",
        :user => "User",
        :status => stub_model(Status, :value => "value"),
        :place => @place
      ),
      stub_model(Place,
        :value => "Value",
        :user => "User",
        :status => stub_model(Status, :value => "value"),
        :place => @place
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
    assert_select "tr>td", :text => "value".to_s, :count => 2
  end
end
