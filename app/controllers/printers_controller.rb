class PrintersController < ApplicationController
  # GET /printers
  # GET /printers.json
  def index
    @printers = Printer.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @printers }
    end
  end

  # GET /printers/1
  # GET /printers/1.json
  def show
    @printer = Printer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @printer }
    end
  end

  # GET /printers/new
  # GET /printers/new.json
  def new
    @printer = Printer.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @printer }
    end
  end

  # GET /printers/1/edit
  def edit
    @printer = Printer.find(params[:id])
  end

  # POST /printers
  # POST /printers.json
  def create
    @printer = Printer.new(params[:printer])

    respond_to do |format|
      if @printer.save
        format.html { redirect_to @printer, notice: 'Printer was successfully created.' }
        format.json { render json: @printer, status: :created, location: @printer }
      else
        format.html { render action: "new" }
        format.json { render json: @printer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /printers/1
  # PUT /printers/1.json
  def update
    @printer = Printer.find(params[:id])

    respond_to do |format|
      if @printer.update_attributes(params[:printer])
        format.html { redirect_to @printer, notice: 'Printer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @printer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /printers/1
  # DELETE /printers/1.json
  def destroy
    @printer = Printer.find(params[:id])
    @printer.destroy

    respond_to do |format|
      format.html { redirect_to printers_url }
      format.json { head :no_content }
    end
  end
end
