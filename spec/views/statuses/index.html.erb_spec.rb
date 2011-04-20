require 'spec_helper'

describe "statuses/index.html.erb" do
  before(:each) do
    assign(:statuses, [
      stub_model(Status,
        :value => "Value",
        :user => 1,
        :status => stub_model(Status, :value => "value"),
        :created_at => DateTime.now
      ),
      stub_model(Status,
        :value => "Value",
        :user => 1,
        :status => stub_model(Status, :value => "value"),
        :created_at => DateTime.now
        
      )
    ])
  end

  it "renders a list of statuses" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    #assert_select "tr>td", :text => "en, model, status, value".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
