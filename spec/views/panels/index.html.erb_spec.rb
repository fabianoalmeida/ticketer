require 'spec_helper'

describe "panels/index.html.erb" do
  before(:each) do
    @place = assign(:place, stub_model(Place, :id => "1"))
    assign(:panels, [
      stub_model(Panel,
        :value => "Value",
        :ip => "Ip",
        :status => stub_model(Status, :value => "Active"),
        :place => stub_model(Place, :value => "Place"),
        :user => "User"
      ),
      stub_model(Panel,
        :value => "Value",
        :ip => "Ip",
        :status => stub_model(Status, :value => "Active"),
        :place => stub_model(Place, :value => "Place"),
        :user => "User"
      )
    ])
  end

  it "renders a list of panels" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Value".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Ip".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Active".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "User".to_s, :count => 2
  end
end
