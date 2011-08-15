class ReportsController < ApplicationController

  def index; end

  def tickets_per_day
    if params[:search]  && params[:search][:start_date] && params[:search][:end_date]
      @tickets_per_day = Report.tickets_per_day(
        params[:search][:start_date].to_date,
        params[:search][:end_date].to_date
      )
    end
    respond_to do |format|
      format.html
      format.json { render :json => @tickets_per_day }
    end
  end

end
