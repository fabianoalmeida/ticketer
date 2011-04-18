require 'spec_helper'

describe "totems/edit.html.erb" do
  before(:each) do
    @place = assign(:place, stub_model(Place, :id => "1"))
    @totem = assign(:totem, stub_model(Totem,
      :value => "MyString",
      :place => @place,
      :ip => "MyString"
    ))
  end

  it "renders the edit totem form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => place_totems_path(@totem.place, @totem), :method => "post" do
      assert_select "input#totem_value", :name => "totem[value]"
      assert_select "input#totem_ip", :name => "totem[ip]"
    end
  end
end
