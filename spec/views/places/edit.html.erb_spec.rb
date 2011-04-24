require 'spec_helper'

describe "places/edit.html.erb" do
  before(:each) do
    @place = assign(:place, stub_model(Place,
      :value => "MyString",
      :user => "MyString",
      :status => stub_model(Status, :value => "value"),
      :local => stub_model(Local, :value =>"some", :id => "1")
    ))

    @place.stub(:ticket_types){[]}
  end

  it "renders the edit place form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => places_path(@place), :method => "post" do
      assert_select "input#place_value", :name => "place[value]"
      assert_select "select#place_local_id", :name => "place[local_id]"
      #assert_select "input#place_status_id", :name => "place[status_id]"
    end
  end
end
