class ReportsController < ApplicationController

  def index; end

  def tickets_per_day
    respond_to do |format|
      unless params[:start_date].blank? && params[:end_date].blank?
        @tickets_per_day = Report.tickets_per_day(
          params[:start_date].to_date,
          params[:end_date].to_date
        )
        unless @tickets_per_day.empty?
          format.html
          format.json { render :json => @tickets_per_day }
        end
      else
        format.html {render :notice => I18n.t('application.no_results')}
        format.json {render :json => nil}
      end
    end
  end

end
