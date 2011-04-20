require 'spec_helper'

describe "locals/show.html.erb" do
  before(:each) do
    @local = assign(:local, stub_model(Local,
      :des_local => "Value"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Value/)
  end
end
