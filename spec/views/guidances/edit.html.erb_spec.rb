require 'spec_helper'

describe "guidances/edit.html.erb" do
  before(:each) do
    @guidance = assign(:guidance, stub_model(Guidance,
      :value => "MyString",
      :user => "MyString"
    ))
  end

  it "renders the edit guidance form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => guidances_path(@guidance), :method => "post" do
      assert_select "input#guidance_value", :name => "guidance[value]"
    end
  end
end
