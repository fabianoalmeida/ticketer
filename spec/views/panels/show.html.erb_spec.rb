require 'spec_helper'

describe "panels/show.html.erb" do
  before(:each) do
    @place = assign(:place, stub_model(Place, :id => "1"))
    @panel = assign(:panel, stub_model(Panel,
      :value => "Value",
      :ip => "Ip",
      :status => stub_model(Status, :value => "value"),
      :user => "User",
      :place => @place
      
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Value/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Ip/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/value/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/User/)
  end
end
