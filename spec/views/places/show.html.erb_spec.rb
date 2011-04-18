require 'spec_helper'

describe "places/show.html.erb" do
  before(:each) do
    @place = assign(:place, stub_model(Place,
      :value => "Value",
      :user => "User",
      :local => stub_model(Local, :des_local => "Some"),
      :status => stub_model(Status, :value => "value")
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Value/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/User/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
  end
end
