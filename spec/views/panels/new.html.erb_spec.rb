require 'spec_helper'

describe "panels/new.html.erb" do
  before(:each) do
    @place = assign(:place, stub_model(Place, :id => "1"))
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
    assert_select "form", :action => place_panels_path(@place), :method => "post" do
      assert_select "input#panel_value", :name => "panel[value]"
      assert_select "input#panel_ip", :name => "panel[ip]"
    end
  end
end
