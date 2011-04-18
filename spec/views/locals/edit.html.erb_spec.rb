require 'spec_helper'

describe "locals/edit.html.erb" do
  before(:each) do
    @local = assign(:local, stub_model(Local,
      :des_local => "MyString"
      #:status_id => 1,
      #:user => "MyString"
    ))
  end

  it "renders the edit local form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => locals_path(@local), :method => "post" do
      assert_select "input#local_des_local", :name => "local[des_local]"
      #assert_select "input#local_status_id", :name => "local[status_id]"
      #assert_select "input#local_user", :name => "local[user]"
    end
  end
end
