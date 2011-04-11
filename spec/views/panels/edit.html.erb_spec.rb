require 'spec_helper'

describe "panels/edit.html.erb" do
  before(:each) do
    @panel = assign(:panel, stub_model(Panel,
      :value => "MyString",
      :ip => "MyString",
      :status_id => 1,
      :user => "MyString"
    ))
  end

  it "renders the edit panel form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => panels_path(@panel), :method => "post" do
      assert_select "input#panel_value", :name => "panel[value]"
      assert_select "input#panel_ip", :name => "panel[ip]"
      assert_select "input#panel_status_id", :name => "panel[status_id]"
      assert_select "input#panel_user", :name => "panel[user]"
    end
  end
end
