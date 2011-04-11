require 'spec_helper'

describe "guidances/new.html.erb" do
  before(:each) do
    assign(:guidance, stub_model(Guidance,
      :value => "MyString",
      :user => "MyString"
    ).as_new_record)
  end

  it "renders new guidance form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => guidances_path, :method => "post" do
      assert_select "input#guidance_value", :name => "guidance[value]"
      assert_select "input#guidance_user", :name => "guidance[user]"
    end
  end
end
