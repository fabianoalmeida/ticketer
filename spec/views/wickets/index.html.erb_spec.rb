require 'spec_helper'

describe "wickets/index.html.erb" do
  before(:each) do
    @place = assign(:place, stub_model(Place, :id => "1"))
    assign(:wickets, [
      stub_model(Wicket,
        :value => "Value",
        :guidance => stub_model(Guidance, :value => "value"),
        :status => stub_model(Status, :value => "value"),
        :user => "User",
        :place => @place
      ),
      stub_model(Wicket,
        :value => "Value",
        :guidance => stub_model(Guidance, :value => "value"),
        :status => stub_model(Status, :value => "value"),
        :user => "User",
        :place => @place
      )
    ])
  end

  it "renders a list of wickets" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Value".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Value".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Value".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "User".to_s, :count => 2
  end
end
