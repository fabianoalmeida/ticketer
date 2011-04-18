require 'spec_helper'

describe "panels/new.html.erb" do
  before(:each) do
    assign(:panel, stub_model(Panel,
      :value => "MyString",
      :ip => "MyString",
      :status => stub_model(Status, :value => "Active"),
      :user => "MyString"
    ).as_new_record)
  end

  it "renders new panel form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => panels_path, :method => "post" do
      assert_select "input#panel_value", :name => "panel[value]"
      assert_select "input#panel_ip", :name => "panel[ip]"
      assert_select "input#panel_status", :name => "panel[status]"
      assert_select "input#panel_user", :name => "panel[user]"
    end
  end
end
