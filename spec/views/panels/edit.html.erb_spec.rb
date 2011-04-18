require 'spec_helper'

describe "panels/edit.html.erb" do
  before(:each) do
    @place = assign(:place, stub_model(Place, :id => "1"))
    @panel = assign(:panel, stub_model(Panel,
      :value => "MyString",
      :ip => "MyString",
      :status_id => 1,
      :user => "MyString",
      :place => @place
    ))
  end

  it "renders the edit panel form" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => place_panels_path(@place, @panel), :method => "post" do
      assert_select "input#panel_value", :name => "panel[value]"
      assert_select "input#panel_ip", :name => "panel[ip]"
      #assert_select "input#panel_status_id", :name => "panel[status_id]"
      assert_select "input#panel_user", :name => "panel[user]"
    end
  end
end
