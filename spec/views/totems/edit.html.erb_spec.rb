require 'spec_helper'

describe "totems/edit.html.erb" do
  before(:each) do
    @totem = assign(:totem, stub_model(Totem,
      :value => "MyString",
      :ip => "MyString"
    ))
  end

  it "renders the edit totem form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => totems_path(@totem), :method => "post" do
      assert_select "input#totem_value", :name => "totem[value]"
      assert_select "input#totem_ip", :name => "totem[ip]"
    end
  end
end
