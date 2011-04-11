require 'spec_helper'

describe "wickets/show.html.erb" do
  before(:each) do
    @wicket = assign(:wicket, stub_model(Wicket,
      :value => "Value",
      :guidance_id => 1,
      :status_id => 1,
      :user => "User"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Value/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/User/)
  end
end
