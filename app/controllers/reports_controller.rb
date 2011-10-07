class ReportsController < ApplicationController

  prawnto :filename => "#{DateTime.now.to_i}.pdf", :inline => false

  def index
    @place = Place.find(params[:place_id])
  end

  def tickets_per_day
    filter_date 
    @report = Report.tickets_per_day(@first_date, @second_date).to(@place)
    handle_result @report, :tickets_per_day
  end

  def attendances_by_wickets_per_day
    filter_date
    @report = Report.attendances_by_wickets_per_day(@first_date, @second_date).to(@place)
    handle_result @report, :attendances_per_day
  end
  
  def tickets_per_month
    filter_place
    @report = Report.tickets_per_month(params[:start_date], params[:end_date]).to(@place)
    handle_result  @report,  :tickets_per_month 
  end 

  def attendances_by_wickets_per_month
    filter_wicket
    @report = Report.attendances_by_wickets_per_month(params[:start_date], params[:end_date])
                    .to(@place)
                    .filtered_by(@wicket_ids)
    handle_result @report, :attendances_per_month
  end

  def attendances_by_month_per_wicket
    filter_wicket
    @report = Report.attendances_by_month_per_wicket(params[:start_date], params[:end_date])
                    .to(@place)
                    .filtered_by(@wicket_ids)
    handle_result @report, :attendances_per_month
  end

  def attendances_by_days_per_wicket
    filter_date
    @report = Report.attendances_by_days_per_wicket(@first_date, @second_date).to(@place)
    handle_result @report, :attendances_per_wicket
  end
 
  def waiting_time_by_client 
    filter_date
    @report = Report.waiting_time_by_client(@first_date, @second_date).to(@place)
    handle_result @report, :waiting_time_by_client
  end
 
  def waiting_time_by_client_per_month
    filter_place
    @report = Report.waiting_time_by_client_per_month(params[:start_date], params[:end_date]).to(@place)
    handle_result @report, :waiting_time_clients_per_month
  end
  
  def waiting_time_by_wicket
    filter_date
    @report = Report.waiting_time_by_wicket(@first_date, @second_date).to(@place)
    handle_result @report, :waiting_time_by_wicket  
  end
 
  def waiting_time_by_wicket_per_month
    filter_wicket
    @report = Report.waiting_time_by_wicket_per_month(params[:start_date], params[:end_date])
                    .to(@place)
                    .filtered_by(@wicket_ids)
    handle_result @report, :wickets_per_month
  end

  def waiting_time_by_month_per_wicket
    filter_wicket
    @report = Report.waiting_time_by_month_per_wicket(params[:start_date], params[:end_date])
                    .to(@place)
                    .filtered_by(@wicket_ids)
    handle_result @report, :wickets_per_month
  end

  def waiting_time_by_day_per_wicket
    filter_date
    @report = Report.waiting_time_by_day_per_wicket(@first_date, @second_date).to(@place)
    handle_result @report, :waiting_time_by_wicket  
  end

  private 
   
  def handle_result(report, result) 
    respond_to do |format|
      if report.valid?
        instance_variable_set("@#{result}", report.results)
        format.html
        format.json { render :json => instance_variable_get("@#{result}") }
        format.pdf { render :layout => false }
      else
        format.html {render :notice => I18n.t('application.no_results')}
        format.json {render :json => nil}
      end
    end    
  end
  
  def filter_place
    @place = Place.find(params[:place_id])
  end
  
  def filter_date
    filter_place
    @first_date = params[:start_date] && params[:start_date].to_date 
    @second_date = params[:end_date] && params[:end_date].to_date
    filter_wicket
  end
  
  def filter_wicket
    filter_place
    @wickets = @place.wickets
    @wicket_ids = params[:wicket][:ids] unless params[:wicket].nil?
  end
    
end
