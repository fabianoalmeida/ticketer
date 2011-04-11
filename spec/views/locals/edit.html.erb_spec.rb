require 'spec_helper'

describe "locals/edit.html.erb" do
  before(:each) do
    @local = assign(:local, stub_model(Local,
      :value => "MyString",
      :status_id => 1,
      :user => "MyString"
    ))
  end

  it "renders the edit local form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => locals_path(@local), :method => "post" do
      assert_select "input#local_value", :name => "local[value]"
      assert_select "input#local_status_id", :name => "local[status_id]"
      assert_select "input#local_user", :name => "local[user]"
    end
  end
end
