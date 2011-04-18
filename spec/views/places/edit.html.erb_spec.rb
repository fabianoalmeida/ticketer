require 'spec_helper'

describe "places/edit.html.erb" do
  before(:each) do
    @place = assign(:place, stub_model(Place,
      :value => "MyString",
      :user => "MyString",
      :status => stub_model(Status, :value => "value")
    ))
  end

  it "renders the edit place form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => places_path(@place), :method => "post" do
      assert_select "input#place_value", :name => "place[value]"
      assert_select "input#place_user", :name => "place[user]"
      #assert_select "input#place_status_id", :name => "place[status_id]"
    end
  end
end
