class LocalsController < ApplicationController
  def index
    @locals = Local.all
    respond_with(@locals)
  end

  def show
    @local = Local.find(params[:id])
    respond_with(@local)
  end

  def new
    @local = Local.new
    respond_with(@local)
  end

  def edit
    @local = Local.find(params[:id])
  end

  def create
    @local = Local.new(params[:local])
    flash[:notice] = "Local was successfully created." if @local.save
    respond_with(@local)
  end

  def update
    @local = Local.find(params[:id])
    flash[:notice] = "Local was successfully updated." if @local.update_attributes(params[:local])
    respond_with(@local)
  end
end
