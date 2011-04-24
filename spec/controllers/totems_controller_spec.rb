require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by the Rails when you ran the scaffold generator.

describe TotemsController do

  before(:each ) do
    Place.stub(:find).with("1") {mock_place}
  end

  def mock_place(stubs={})
    @mock_place ||= mock_model(Place, stubs).as_null_object
  end

  def mock_totem(stubs={})
    @mock_totem ||= mock_model(Totem, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all totems as @totems" do
      Totem.stub(:where) { [mock_totem] }
      get :index, :place_id => "1"
      assigns(:totems).should eq([mock_totem])
    end
  end

  describe "GET show" do
    it "assigns the requested totem as @totem" do
      Totem.stub(:find).with("37") { mock_totem }
      get :show, :id => "37", :place_id => "1"
      assigns(:totem).should be(mock_totem)
    end
  end

  describe "GET new" do
    it "assigns a new totem as @totem" do
      Totem.stub(:new) { mock_totem }
      get :new, :place_id => "1"
      assigns(:totem).should be(mock_totem)
    end
  end

  describe "GET edit" do
    it "assigns the requested totem as @totem" do
      Totem.stub(:find).with("37") { mock_totem }
      get :edit, :id => "37", :place_id => "1"
      assigns(:totem).should be(mock_totem)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "assigns a newly created totem as @totem" do
        Totem.stub(:new).with({'these' => 'params'}) { mock_totem(:save => true) }
        post :create, :totem => {'these' => 'params'}, :place_id => "1"
        assigns(:totem).should be(mock_totem)
      end

      it "redirects to the created totem" do
        Totem.stub(:new) { mock_totem(:save => true) }
        post :create, :totem => {}, :place_id => "1"
        response.should redirect_to(place_totem_url(mock_place, mock_totem))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved totem as @totem" do
        Totem.stub(:new).with({'these' => 'params'}) { mock_totem(:save => false) }
        post :create, :totem => {'these' => 'params'}, :place_id => "1"
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested totem" do
        Totem.stub(:find).with("37") { mock_totem }
        mock_totem.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :totem => {'these' => 'params'}, :place_id => "1"
      end

      it "assigns the requested totem as @totem" do
        Totem.stub(:find) { mock_totem(:update_attributes => true) }
        put :update, :id => "1", :place_id => "1"
        assigns(:totem).should be(mock_totem)
      end

      it "redirects to the totem" do
        Totem.stub(:find) { mock_totem(:update_attributes => true) }
        put :update, :id => "1", :place_id => "1"
        response.should redirect_to(place_totem_url(mock_place, mock_totem))
      end
    end

    describe "with invalid params" do
      it "assigns the totem as @totem" do
        Totem.stub(:find) { mock_totem(:update_attributes => false) }
        put :update, :id => "1", :place_id => "1"
        assigns(:totem).should be(mock_totem)
      end

      it "re-renders the 'edit' template" do
        Totem.stub(:find) { mock_totem(:update_attributes => false) }
        put :update, :id => "1", :place_id => "1"
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested totem" do
      Totem.stub(:find).with("37") { mock_totem }
      mock_totem.should_receive(:destroy)
      delete :destroy, :id => "37", :place_id => "1"
    end

    it "redirects to the totems list" do
      Totem.stub(:find) { mock_totem }
      delete :destroy, :id => "1", :place_id => "1"
      response.should redirect_to(place_totems_url(mock_place))
    end
  end

  describe "GET generate_ticket" do

    def mock_ticket_types(stubs={})
      @mock_ticket_types ||= mock_model(TicketType, stubs)      
    end

    def mock_place(stubs={})
      @mock_place ||= mock_model(Place, stubs)
    end

    it "assigns all ticket_types that exists" do
      Place.stub(:where).with({:id => "1"}) { [ mock_place(:ticket_types => [mock_ticket_types]) ]}
      get :generate_ticket, :place_id => "1", :totem_id => "1"
      assigns(:ticket_types).should eq([mock_ticket_types])
    end
  end

end
