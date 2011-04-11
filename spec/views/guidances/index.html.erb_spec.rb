require 'spec_helper'

describe "guidances/index.html.erb" do
  before(:each) do
    assign(:guidances, [
      stub_model(Guidance,
        :value => "Value",
        :user => "User"
      ),
      stub_model(Guidance,
        :value => "Value",
        :user => "User"
      )
    ])
  end

  it "renders a list of guidances" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Value".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "User".to_s, :count => 2
  end
end
