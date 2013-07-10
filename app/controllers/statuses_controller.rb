class StatusesController < ApplicationController
  def index
    @statuses = Status.all
    respond_with(@statuses)
  end

  def show
    @status = Status.find(params[:id])
    respond_with(@status)
  end

  def new
    @status = Status.new
    respond_with(@status)
  end

  def edit
    @status = Status.find(params[:id])
  end

  def create
    @status = Status.new(params[:status])
    @status.user = "user test"
    flash[:notice] = "Status was successfully created." if @status.save
    respond_with(@status)
  end

  def update
    @status = Status.find(params[:id])
    flash[:notice] = "Status was successfully updated." if @status.update_attributes(params[:status])
    respond_with(@status)
  end
end
