require 'spec_helper'

describe "wickets/index.html.erb" do
  before(:each) do
    assign(:wickets, [
      stub_model(Wicket,
        :value => "Value",
        :guidance_id => 1,
        :status_id => 1,
        :user => "User"
      ),
      stub_model(Wicket,
        :value => "Value",
        :guidance_id => 1,
        :status_id => 1,
        :user => "User"
      )
    ])
  end

  it "renders a list of wickets" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Value".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 4
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 4
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "User".to_s, :count => 2
  end
end
