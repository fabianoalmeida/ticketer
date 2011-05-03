require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by the Rails when you ran the scaffold generator.

describe WicketsController do

  before(:each ) do
    Place.stub(:find).with("1") {mock_place}
  end

  def mock_place(stubs={})
    @mock_place ||= mock_model(Place, stubs).as_null_object
  end

  def mock_wicket(stubs={})
    @mock_wicket ||= mock_model(Wicket, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all wickets as @wickets" do
      Wicket.stub(:where) { [mock_wicket] }
      get :index, :place_id => "1"
      assigns(:wickets).should eq([mock_wicket])
    end
  end

  describe "GET show" do
    it "assigns the requested wicket as @wicket" do
      Wicket.stub(:find).with("37") { mock_wicket }
      get :show, :id => "37", :place_id => "1"
      assigns(:wicket).should be(mock_wicket)
    end
  end

  describe "GET new" do
    it "assigns a new wicket as @wicket" do
      Wicket.stub(:new) { mock_wicket }
      get :new, :place_id => "1"
      assigns(:wicket).should be(mock_wicket)
    end
  end

  describe "GET edit" do
    it "assigns the requested wicket as @wicket" do
      Wicket.stub(:find).with("37") { mock_wicket }
      get :edit, :id => "37", :place_id => "1"
      assigns(:wicket).should be(mock_wicket)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "assigns a newly created wicket as @wicket" do
        Wicket.stub(:new).with({'these' => 'params'}) { mock_wicket(:save => true) }
        post :create, :wicket => {'these' => 'params'}, :place_id => "1"
        assigns(:wicket).should be(mock_wicket)
      end

      it "redirects to the created wicket" do
        Wicket.stub(:new) { mock_wicket(:save => true) }
        post :create, :wicket => {}, :place_id => "1"
        response.should redirect_to(place_wicket_url(mock_place, mock_wicket))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved wicket as @wicket" do
        Wicket.stub(:new).with({'these' => 'params'}) { mock_wicket(:save => false) }
        post :create, :wicket => {'these' => 'params'}, :place_id => "1"
        assigns(:wicket).should be(mock_wicket)
      end

      it "re-renders the 'new' template" do
        Wicket.stub(:new) { mock_wicket(:save => false) }
        post :create, :wicket => {}, :place_id => "1"
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested wicket" do
        Wicket.stub(:find).with("37") { mock_wicket }
        mock_wicket.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :wicket => {'these' => 'params'}, :place_id => "1"
      end

      it "assigns the requested wicket as @wicket" do
        Wicket.stub(:find) { mock_wicket(:update_attributes => true) }
        put :update, :id => "1", :place_id => "1"
        assigns(:wicket).should be(mock_wicket)
      end

      it "redirects to the wicket" do
        Wicket.stub(:find) { mock_wicket(:update_attributes => true) }
        put :update, :id => "1", :place_id => "1"
        response.should redirect_to(place_wicket_url(mock_place, mock_wicket))
      end
    end

    describe "with invalid params" do
      it "assigns the wicket as @wicket" do
        Wicket.stub(:find) { mock_wicket(:update_attributes => false) }
        put :update, :id => "1", :place_id => "1"
        assigns(:wicket).should be(mock_wicket)
      end

      it "re-renders the 'edit' template" do
        Wicket.stub(:find) { mock_wicket(:update_attributes => false) }
        put :update, :id => "1", :place_id => "1"
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested wicket" do
      Wicket.stub(:find).with("37") { mock_wicket }
      mock_wicket.should_receive(:destroy)
      delete :destroy, :id => "37", :place_id => "1"
    end

    it "redirects to the wickets list" do
      Wicket.stub(:find) { mock_wicket }
      delete :destroy, :id => "1", :place_id => "1"
      response.should redirect_to(place_wickets_url(mock_place))
    end
  end

  context "Ticket Operatios" do

    def mock_ticket(stubs={})
      @mock_tickets ||= mock_model(Ticket, stubs) 
    end

    def mock_ticket_type(stubs={})
      @mock_ticket_type ||= mock_model(TicketType, stubs)
    end

    before(:each) do
      Wicket.stub(:find).with("1") { mock_wicket }
      CallHistory.stub!(:register).and_return(nil)
    end

    describe "GET tickets" do

      it "assigns all tickets for the place where  are the @wickets" do
        mock_wicket.stub(:called_tickets).and_return([mock_ticket])
        mock_wicket.stub(:pending_tickets).and_return([mock_ticket])
        Ticket.stub(:available_for_place).with("1") { [mock_ticket] }
        Factory(:status_ticket, :value => "Called")
        Factory(:status_ticket, :value => "Pending")
        get :tickets, :place_id => "1", :wicket_id => "1"
        assigns(:tickets).should eq([mock_ticket])
      end
    end
    
    describe "POST call_ticket" do

      before(:each) do
        Ticket.stub(:next_to).and_return(mock_ticket(:call => true)) 
        post :call_next, :place_id => "1", :wicket_id => "1"
      end

      it "call the next ticket" do
        assigns(:next_ticket).should eq(mock_ticket)
      end
       
      it "should redirect to #tickets" do 
        response.should redirect_to(place_wicket_tickets_url("1", "1"))
      end
    end

    describe "POST recall ticket" do
      
      before(:each) do
        Ticket.stub(:find).and_return(mock_ticket(:recall => true)) 
        post :recall, :place_id => "1", :wicket_id => "1", :ticket_id => "1"
      end

      it "recall the same ticket" do
        assigns(:ticket_recalled).should eq(mock_ticket)
      end
       
      it "should redirect to #tickets" do 
        response.should redirect_to(place_wicket_tickets_url("1", "1"))
      end
    end

    describe "POST put waiting ticket" do
     
      before(:each) do
        Ticket.stub(:find).and_return(mock_ticket(:pending => true)) 
        put :put_waiting, :place_id => "1", :wicket_id => "1", :ticket_id => "1"
      end

      it "put waiting the given ticket" do
        assigns(:ticket).should be_nil
      end
       
      it "should redirect to #tickets" do 
        response.should redirect_to(place_wicket_tickets_url("1", "1"))
      end
    end

    describe "POST attending ticket" do

      before(:each) do
        Ticket.stub(:find).and_return(mock_ticket(:attend => true))
        post :attend, :place_id => "1", :wicket_id => "1", :ticket_id => "1"
      end

      it "attending the given ticket" do
        assigns(:ticket).should be_nil
      end

      it "should redirect to #tickets" do
        response.should redirect_to(place_wicket_tickets_url("1", "1"))
      end
    end

    describe "DELETE cancel ticket" do
     
      before(:each) do
        Ticket.stub(:find).and_return(mock_ticket(:cancel => true)) 
        delete :cancel, :place_id => "1", :wicket_id => "1", :ticket_id => "1"
      end

      it "put waiting  the given ticket ticket" do
        assigns(:ticket_canceled).should eq(mock_ticket)
      end
       
      it "should redirect to #tickets" do 
        response.should redirect_to(place_wicket_tickets_url("1", "1"))
      end
    end
  end
end
