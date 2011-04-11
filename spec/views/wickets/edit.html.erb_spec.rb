require 'spec_helper'

describe "wickets/edit.html.erb" do
  before(:each) do
    @wicket = assign(:wicket, stub_model(Wicket,
      :value => "MyString",
      :guidance_id => 1,
      :status_id => 1,
      :user => "MyString"
    ))
  end

  it "renders the edit wicket form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => wickets_path(@wicket), :method => "post" do
      assert_select "input#wicket_value", :name => "wicket[value]"
      assert_select "input#wicket_guidance_id", :name => "wicket[guidance_id]"
      assert_select "input#wicket_status_id", :name => "wicket[status_id]"
      assert_select "input#wicket_user", :name => "wicket[user]"
    end
  end
end
