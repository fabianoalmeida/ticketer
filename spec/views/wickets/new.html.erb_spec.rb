require 'spec_helper'

describe "wickets/new.html.erb" do
  before(:each) do
    @place = assign(:place, stub_model(Place, :id => "1"))
    @wicket = assign(:wicket, stub_model(Wicket,
      :value => "MyString",
      :guidance => true,
      #:status => stub_model(Status),
      #:user => "MyString",
      :place => @place
    ).as_new_record)
  end

  it "renders new wicket form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => place_wickets_path(@place), :method => "post" do
      assert_select "input#wicket_value", :name => "wicket[value]"
      #assert_select "select#wicket_guidance", :name => "wicket[guidance]"
      #assert_select "input#wicket_status_id_1", :name => "wicket[status_id]"
      #assert_select "input#wicket_user", :name => "wicket[user]"
    end
  end
end
