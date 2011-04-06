require 'spec_helper'

describe "statuses/new.html.erb" do
  before(:each) do
    assign(:status, stub_model(Status,
      :value => "MyString",
      :user => 1
    ).as_new_record)
  end

  it "renders new status form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => statuses_path, :method => "post" do
      assert_select "input#status_value", :name => "status[value]"
    end
  end
end
