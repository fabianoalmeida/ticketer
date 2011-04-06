require 'spec_helper'

describe "statuses/show.html.erb" do
  before(:each) do
    @status = assign(:status, stub_model(Status,
      :value => "Value",
      :user => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Value/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
  end
end
