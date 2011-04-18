require 'spec_helper'

describe "wickets/new.html.erb" do
  before(:each) do
    assign(:wicket, stub_model(Wicket,
      :value => "MyString",
      :guidance => stub_model(Guidance),
      :status => stub_model(Status),
      :user => "MyString"
    ).as_new_record)
  end

  it "renders new wicket form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => wickets_path, :method => "post" do
      assert_select "input#wicket_value", :name => "wicket[value]"
      assert_select "input#wicket_guidance", :name => "wicket[guidance]"
      assert_select "input#wicket_status", :name => "wicket[status]"
      assert_select "input#wicket_user", :name => "wicket[user]"
    end
  end
end
