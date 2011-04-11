require 'spec_helper'

describe "guidances/show.html.erb" do
  before(:each) do
    @guidance = assign(:guidance, stub_model(Guidance,
      :value => "Value",
      :user => "User"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Value/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/User/)
  end
end
