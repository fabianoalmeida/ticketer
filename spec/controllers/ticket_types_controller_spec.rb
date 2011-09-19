require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by the Rails when you ran the scaffold generator.

describe TicketTypesController do


  render_views

  before( :each ) do
    TicketTypeGroup.stub(:find).with("1") {mock_ticket_type_group}
  end

  def mock_ticket_type_group(stubs={})
    @mock_ticket_type_group ||= mock_model(TicketTypeGroup, stubs).as_null_object
  end

  def mock_ticket_type(stubs={})
    @mock_ticket_type ||= mock_model(TicketType, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all ticket_types as @ticket_types" do
      TicketType.stub(:where) { [mock_ticket_type] }
      get :index, :ticket_type_group_id => "1"
      assigns(:ticket_types).should eq([mock_ticket_type])
    end
  end

  describe "GET show" do
    it "assigns the requested ticket_type as @ticket_type" do
      TicketType.stub(:find).with("37") { mock_ticket_type }
      get :show, :id => "37", :ticket_type_group_id => "1"
      assigns(:ticket_type).should be(mock_ticket_type)
    end
  end

  describe "GET new" do
    it "assigns a new ticket_type as @ticket_type" do
      TicketType.stub(:new) { mock_ticket_type }
      get :new, :ticket_type_group_id => "1"
      assigns(:ticket_type).should be(mock_ticket_type)
    end
  end

  describe "GET edit" do
    it "assigns the requested ticket_type as @ticket_type" do
      TicketType.stub(:find).with("37") { mock_ticket_type }
      get :edit, :id => "37", :ticket_type_group_id => "1"
      assigns(:ticket_type).should be(mock_ticket_type)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "assigns a newly created ticket_type as @ticket_type" do
        TicketType.stub(:new).with({'these' => 'params'}) { mock_ticket_type(:save => true) }
        post :create, :ticket_type => {'these' => 'params'}, :ticket_type_group_id => "1"
        assigns(:ticket_type).should be(mock_ticket_type)
      end

      it "redirects to the created ticket_type" do
        TicketType.stub(:new) { mock_ticket_type(:save => true) }
        post :create, :ticket_type => {}, :ticket_type_group_id => "1"
        response.should redirect_to(ticket_type_group_ticket_type_url(mock_ticket_type_group, mock_ticket_type))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved ticket_type as @ticket_type" do
        TicketType.stub(:new).with({'these' => 'params'}) { mock_ticket_type(:save => false) }
        post :create, :ticket_type => {'these' => 'params'}, :ticket_type_group_id => "1"
        assigns(:ticket_type).should be(mock_ticket_type)
      end

      it "re-renders the 'new' template" do
        TicketType.stub(:new) { mock_ticket_type(:save => false) }
        post :create, :ticket_type => {}, :ticket_type_group_id => "1"
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested ticket_type" do
        TicketType.stub(:find).with("37") { mock_ticket_type }
        mock_ticket_type.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :ticket_type => {'these' => 'params'}, :ticket_type_group_id => "1"
      end

      it "assigns the requested ticket_type as @ticket_type" do
        TicketType.stub(:find) { mock_ticket_type(:update_attributes => true) }
        put :update, :id => "1", :ticket_type_group_id => "1"
        assigns(:ticket_type).should be(mock_ticket_type)
      end

      it "redirects to the ticket_type" do
        TicketType.stub(:find) { mock_ticket_type(:update_attributes => true) }
        put :update, :id => "1", :ticket_type_group_id => "1"
        response.should redirect_to(ticket_type_group_ticket_type_url(mock_ticket_type_group, mock_ticket_type))
      end
    end

    describe "with invalid params" do
      it "assigns the ticket_type as @ticket_type" do
        TicketType.stub(:find) { mock_ticket_type(:update_attributes => false) }
        put :update, :id => "1", :ticket_type_group_id => "1"
        assigns(:ticket_type).should be(mock_ticket_type)
      end

      it "re-renders the 'edit' template" do
        TicketType.stub(:find) { mock_ticket_type(:update_attributes => false) }
        put :update, :id => "1", :ticket_type_group_id => "1"
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested ticket_type" do
      TicketType.stub(:find).with("37") { mock_ticket_type }
      mock_ticket_type.should_receive(:status=) 
      delete :destroy, :id => "37", :ticket_type_group_id => "1"
    end

    it "redirects to the ticket_types list" do
      TicketType.stub(:find) { mock_ticket_type }
      delete :destroy, :id => "1", :ticket_type_group_id => "1"
      response.should redirect_to(ticket_type_group_ticket_types_url)
    end
  end

end
