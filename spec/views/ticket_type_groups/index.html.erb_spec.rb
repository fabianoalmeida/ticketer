require 'spec_helper'

describe "ticket_type_groups/index.html.erb" do
  before(:each) do
    assign(:ticket_type_groups, [
      stub_model(TicketTypeGroup,
        :value => "Value"
      ),
      stub_model(TicketTypeGroup,
        :value => "Value"
      )
    ])
  end

  it "renders a list of ticket_type_groups" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Value".to_s, :count => 2
  end
end
