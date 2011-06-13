require 'spec_helper'

describe "ticket_type_groups/new.html.erb" do
  before(:each) do
    assign(:ticket_type_group, stub_model(TicketTypeGroup,
      :value => "MyString"
    ).as_new_record)
  end

  it "renders new ticket_type_group form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => ticket_type_groups_path, :method => "post" do
      assert_select "input#ticket_type_group_value", :name => "ticket_type_group[value]"
    end
  end
end
