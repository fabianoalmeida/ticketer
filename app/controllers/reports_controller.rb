class ReportsController < ApplicationController

  prawnto :filename => "#{DateTime.now.to_i}.pdf", :inline => false

  def index; end

  def tickets_per_day
    respond_to do |format|
      unless(params[:start_date].blank? && params[:end_date].blank?)
        @tickets_per_day = Report.tickets_per_day(
          params[:start_date].to_date,
          params[:end_date].to_date
        )
        unless @tickets_per_day.empty?
          format.html
          format.json { render :json => @tickets_per_day }
          format.pdf { render :layout => false }
        end
      end
      format.html {render :notice => I18n.t('application.no_results')}
      format.json {render :json => nil}
    end
  end

  def attendances_by_wickets_per_day
    respond_to do |format|
      unless (params[:start_date].blank? && params[:end_date].blank?)
        @attendances_per_day = Report.attendances_by_wickets_per_day(
          params[:start_date].to_date,
          params[:end_date].to_date
        )
        unless @attendances_per_day.empty?
          format.html
          format.json { render :json => @attendances_per_day.to_json }
          format.pdf { render :layout => false }
        end
      else
        format.html {render :notice => I18n.t('application.no_results')}
        format.json {render :json => nil}
      end
      format.html {render :notice => I18n.t('application.no_results')}
      format.json {render :json => nil}
    end
  end
  
    def waiting_time_by_wicket
    respond_to do |format|
      unless params[:start_date].blank? && params[:end_date].blank?
        unless (params[:end_date].to_date - params[:start_date].to_date).to_i > 15
          @waiting_time_by_wicket = Report.waiting_time_by_wicket(
            params[:start_date].to_date,
            params[:end_date].to_date
          )
          unless @waiting_time_by_wicket.empty?
            format.html
            format.json { render :json => @waiting_time_by_wicket }
            format.pdf { render :layout => false }
          else
              format.json {render :json => nil}
          end
        else
          format.html {render :notice => I18n.t('application.no_results')}
          format.json {render :json => nil}
        end
      else
         format.html {render :notice => I18n.t('application.no_results')}
         format.json {render :json => nil}
      end
        format.html {render :notice => I18n.t('application.no_results')}
        format.json {render :json => nil}
    end
  end
  
  def waiting_time_by_client
     respond_to do |format|
       unless params[:start_date].blank? && params[:end_date].blank?
         unless (params[:end_date].to_date - params[:start_date].to_date).to_i > 15
           @waiting_time_by_client = Report.waiting_time_by_client(
             params[:start_date].to_date,
             params[:end_date].to_date
           )
           unless @waiting_time_by_client.empty?
             format.html
             format.json { render :json => @waiting_time_by_client }
             format.pdf { render :layout => false }
           end
         else
            format.html {render :notice => I18n.t('application.no_results')}
            format.json {render :json => nil}
         end
       else
         format.html {render :notice => I18n.t('application.no_results')}
         format.json {render :json => nil}
       end
     end
   end
   
   def tickets_per_month

     respond_to do |format|
       unless(params[:start_date].blank? && params[:end_date].blank?)
         @tickets_per_day = Report.tickets_per_month(
           params[:start_date].to_date,
           params[:end_date].to_date
         )
         unless @tickets_per_day.empty?
           format.html
           format.json { render :json => @tickets_per_day }
           format.pdf { render :layout => false }
         end
       end
       format.html {render :notice => I18n.t('application.no_results')}
       format.json {render :json => nil}
     end    
   end 
end
