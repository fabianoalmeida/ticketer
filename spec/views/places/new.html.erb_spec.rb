require 'spec_helper'

describe "places/new.html.erb" do
  before(:each) do
    assign(:place, stub_model(Place,
      :value => "MyString",
      :user => "MyString",
      :status => stub_model(Status, :value => "value")
    ).as_new_record)
  end

  it "renders new place form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => places_path, :method => "post" do
      assert_select "input#place_value", :name => "place[value]"
      #assert_select "input#place_status_id", :name => "place[status_id]"
    end
  end
end
