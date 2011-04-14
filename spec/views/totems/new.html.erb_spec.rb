require 'spec_helper'

describe "totems/new.html.erb" do
  before(:each) do
    assign(:totem, stub_model(Totem,
      :value => "MyString",
      :ip => "MyString"
    ).as_new_record)
  end

  it "renders new totem form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => totems_path, :method => "post" do
      assert_select "input#totem_value", :name => "totem[value]"
      assert_select "input#totem_ip", :name => "totem[ip]"
    end
  end
end
