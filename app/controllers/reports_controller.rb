class ReportsController < ApplicationController

  prawnto :filename => "#{DateTime.now.to_i}.pdf", :inline => false

  def index; end

  def tickets_per_day

    filter_date 
    @report = Report.tickets_per_day(@first_date, @second_date)
    handle_result @report, :tickets_per_day

  end

  def attendances_by_wickets_per_day

    filter_date
    @report = Report.attendances_by_wickets_per_day( @first_date, @second_date )
    handle_result @report, :attendances_per_day

  end
  
  def waiting_time_by_wicket
    
    filter_date
    @report = Report.waiting_time_by_wicket( @first_date, @second_date )
    handle_result @report, :waiting_time_by_wicket  
  
  end
  
  def waiting_time_by_client 
     
    filter_date
    @report = Report.waiting_time_by_client( @first_date, @second_date )
    handle_result @report, :waiting_time_by_client
     
  end
   
  def tickets_per_month

    @report = Report.tickets_per_month( params[:start_date], params[:end_date] )
    handle_result  @report,  :tickets_per_month 
   
  end 


  def attendances_by_wickets_per_month
    
    @report = Report.attendances_by_wickets_per_month( params[:start_date], params[:end_date] )
    handle_result @report, :attendances_per_month
    
  end

  def waiting_time_by_wicket_per_month
    
    @report = Report.waiting_time_by_wicket_per_month( params[:start_date], params[:end_date] )
    handle_result @report, :wickets_per_month
    
  end

  def attendances_by_days_per_wicket

    filter_date
    @report = Report.attendances_by_days_per_wicket( @first_date, @second_date )
    handle_result @report, :attendances_per_wicket

  end

  def waiting_time_by_day_per_wicket
    
    filter_date
    @report = Report.waiting_time_by_day_per_wicket( @first_date, @second_date )
    handle_result @report, :waiting_time_by_wicket  
  
  end

  def waiting_time_by_client_per_month

    @report = Report.waiting_time_by_client_per_month( params[:start_date], params[:end_date] )
    handle_result @report, :waiting_time_clients_per_month

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
  
  def filter_date
    @first_date = params[:start_date] && params[:start_date].to_date 
    @second_date = params[:end_date] && params[:end_date].to_date
  end
    
end
