require 'spec_helper'

describe "wickets/new.html.erb" do
  before(:each) do
    @ticket_type_group = assign(:ticket_type_group, stub_model(TicketTypeGroup, :id => "1", :value => "Value"))
    @place = assign(:place, stub_model(Place, :id => "1"))
    @place.stub(:ticket_type_groups).and_return([@ticket_type_group])
    @wicket = assign(:wicket, stub_model(Wicket,
      :value => "MyString",
      :guidance => true,
      :place => @place,
      :ticket_type_group => @ticket_type_group
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
