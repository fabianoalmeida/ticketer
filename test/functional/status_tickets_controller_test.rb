require 'test_helper'

class StatusTicketsControllerTest < ActionController::TestCase
  setup do
    @status_ticket = status_tickets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:status_tickets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create status_ticket" do
    assert_difference('StatusTicket.count') do
      post :create, :status_ticket => @status_ticket.attributes
    end

    assert_redirected_to status_ticket_path(assigns(:status_ticket))
  end

  test "should show status_ticket" do
    get :show, :id => @status_ticket.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @status_ticket.to_param
    assert_response :success
  end

  test "should update status_ticket" do
    put :update, :id => @status_ticket.to_param, :status_ticket => @status_ticket.attributes
    assert_redirected_to status_ticket_path(assigns(:status_ticket))
  end

  test "should destroy status_ticket" do
    assert_difference('StatusTicket.count', -1) do
      delete :destroy, :id => @status_ticket.to_param
    end

    assert_redirected_to status_tickets_path
  end
end
