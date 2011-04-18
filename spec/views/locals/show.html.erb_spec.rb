require 'spec_helper'

describe "locals/show.html.erb" do
  before(:each) do
    @local = assign(:local, stub_model(Local,
      :value => "Value"
      #:user => "User",
      #:status => stub_model(Status, :value => "value")
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Value/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    #rendered.should match(/User/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    #rendered.should match(/value/)
  end
end
