class PrintersController < ApplicationController
  def index
    @printers = Printer.all
    respond_with(@printers)
  end

  # GET /printers/1
  # GET /printers/1.json
  def show
    @printer = Printer.find(params[:id])
    respond_with(@printer)
  end

  def new
    @printer = Printer.new
    respond_with(@printer)
  end

  def edit
    @printer = Printer.find(params[:id])
  end

  def create
    @printer = Printer.new(params[:printer])
    flash[:notice] = "Printer was successfully created." if @printer.save
    respond_with(@printer)
  end

  def update
    @printer = Printer.find(params[:id])
    flash[:notice] = "Printer was successfully updated." if @printer.update_attributes(params[:printer])
    respond_with(@printer)
  end
end
