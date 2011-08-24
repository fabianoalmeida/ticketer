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

        rtr = <<-JSON
        [
        ["Guich\u00ea 01",
          {"values":[45,43,22,24,11,15,3,3,3,36,17,33,21,21,26,33,21],
           "dates":["23/08/2011","22/08/2011","19/08/2011","18/08/2011","17/08/2011","16/08/2011","15/08/2011","12/08/2011","11/08/2011","10/08/2011","09/08/2011","08/08/2011","05/08/2011","04/08/2011","03/08/2011","02/08/2011","01/08/2011"]}],
        ["Guich\u00ea 02",
          {"values":[36,39,15,28,37,26,16,5,1,27,24,34,3,20,26,14,24],
           "dates":["23/08/2011","22/08/2011","19/08/2011","18/08/2011","17/08/2011","16/08/2011","15/08/2011","12/08/2011","11/08/2011","10/08/2011","09/08/2011","08/08/2011","05/08/2011","04/08/2011","03/08/2011","02/08/2011","01/08/2011"]}],
        ["Guich\u00ea 03",
          {"values":[20,26,21,16,27,27,15,4,10,9,1,31,35,24,25,31],
           "dates":["23/08/2011","22/08/2011","19/08/2011","18/08/2011","17/08/2011","16/08/2011","15/08/2011","12/08/2011","11/08/2011","10/08/2011","09/08/2011","08/08/2011","04/08/2011","03/08/2011","02/08/2011","01/08/2011"]}],
        ["Guich\u00ea 04",
          {"values":[31,17,10,21,12,6,4,23,16,17,9,29,22,30],
           "dates":["23/08/2011","22/08/2011","19/08/2011","18/08/2011","17/08/2011","16/08/2011","15/08/2011","12/08/2011","09/08/2011","08/08/2011","04/08/2011","03/08/2011","02/08/2011","01/08/2011"]}]]
        JSON

        #@attendances_per_day = ActiveSupport::JSON.decode(rtr)

        unless @attendances_per_day.empty?
          format.html
          format.json { render :json => @attendances_per_day.to_json }
          format.pdf { render :layout => false }
        end
      else
        format.html {render :notice => I18n.t('application.no_results')}
        format.json {render :json => nil}
      end
    end
  end
  
  def waiting_time_by_wicket
    respond_to do |format|
      unless params[:start_date].blank? && params[:end_date].blank?
        @attendances_per_day = Report.waiting_time_by_wicket(
          params[:start_date].to_date,
          params[:end_date].to_date
        )

        rtr = <<-JSON
        [{"wicket":{"data":"15/08/2011","time_release":"0.019837962962962962962962962962962962963","total":2,"wicket_id":1}},
         {"wicket":{"data":"12/08/2011","time_release":"0.0000347222222222222222222222222222222222222","total":1,"wicket_id":1}},
         {"wicket":{"data":"11/08/2011","time_release":"0.000297067901234567901234567901234567901235","total":3,"wicket_id":1}},
         {"wicket":{"data":"10/08/2011","time_release":"0.00408697089947089947089947089947089947091","total":35,"wicket_id":1}},
         {"wicket":{"data":"09/08/2011","time_release":"0.00153501157407407407407407407407407407408","total":8,"wicket_id":1}},
         {"wicket":{"data":"08/08/2011","time_release":"0.00594628033205619412515964240102171136654","total":29,"wicket_id":1}},
         {"wicket":{"data":"05/08/2011","time_release":"0.00206903594771241830065359477124183006537","total":17,"wicket_id":1}},
         {"wicket":{"data":"04/08/2011","time_release":"0.00253045808966861598440545808966861598439","total":19,"wicket_id":1}},
         {"wicket":{"data":"03/08/2011","time_release":"0.00406177662037037037037037037037037037037","total":16,"wicket_id":1}},
         {"wicket":{"data":"02/08/2011","time_release":"0.00171432461873638344226579520697167755991","total":17,"wicket_id":1}},
         {"wicket":{"data":"01/08/2011","time_release":"0.00395016339869281045751633986928104575162","total":17,"wicket_id":1}},
         {"wicket":{"data":"15/08/2011","time_release":"0.0106342592592592592592592592592592592593","total":15,"wicket_id":2}},
         {"wicket":{"data":"12/08/2011","time_release":"0.00729166666666666666666666666666666666666","total":5,"wicket_id":2}},
         {"wicket":{"data":"10/08/2011","time_release":"0.00722222222222222222222222222222222222221","total":25,"wicket_id":2}},
         {"wicket":{"data":"09/08/2011","time_release":"0.00245039682539682539682539682539682539683","total":21,"wicket_id":2}},
         {"wicket":{"data":"08/08/2011","time_release":"0.00967592592592592592592592592592592592592","total":30,"wicket_id":2}},
         {"wicket":{"data":"05/08/2011","time_release":"0.0000115740740740740740740740740740740740741","total":1,"wicket_id":2}},
         {"wicket":{"data":"04/08/2011","time_release":"0.0206195175438596491228070175438596491228","total":19,"wicket_id":2}},
         {"wicket":{"data":"03/08/2011","time_release":"0.0182430555555555555555555555555555555555","total":15,"wicket_id":2}},
         {"wicket":{"data":"02/08/2011","time_release":"0.0657860725308641975308641975308641975309","total":12,"wicket_id":2}},
         {"wicket":{"data":"01/08/2011","time_release":"0.00234722222222222222222222222222222222221","total":20,"wicket_id":2}},
         {"wicket":{"data":"15/08/2011","time_release":"0.000597643097643097643097643097643097643098","total":11,"wicket_id":3}},
         {"wicket":{"data":"12/08/2011","time_release":"0.0143557098765432098765432098765432098765","total":3,"wicket_id":3}},
         {"wicket":{"data":"11/08/2011","time_release":"0.000231481481481481481481481481481481481481","total":1,"wicket_id":3}},
         {"wicket":{"data":"10/08/2011","time_release":"0.00259259259259259259259259259259259259259","total":8,"wicket_id":3}},
         {"wicket":{"data":"09/08/2011","time_release":"0.000127314814814814814814814814814814814815","total":1,"wicket_id":3}},
         {"wicket":{"data":"08/08/2011","time_release":"0.00301986882716049382716049382716049382715","total":24,"wicket_id":3}},
         {"wicket":{"data":"04/08/2011","time_release":"0.0031788446054750402576489533011272141707","total":23,"wicket_id":3}},
         {"wicket":{"data":"03/08/2011","time_release":"0.00494386574074074074074074074074074074074","total":20,"wicket_id":3}},
         {"wicket":{"data":"02/08/2011","time_release":"0.00329552469135802469135802469135802469137","total":15,"wicket_id":3}},
         {"wicket":{"data":"01/08/2011","time_release":"0.00537663966049382716049382716049382716049","total":24,"wicket_id":3}},
         {"wicket":{"data":"15/08/2011","time_release":"0.0076707175925925925925925925925925925926","total":4,"wicket_id":4}},
         {"wicket":{"data":"12/08/2011","time_release":"0.00806344696969696969696969696969696969697","total":22,"wicket_id":4}},
         {"wicket":{"data":"09/08/2011","time_release":"0.00627403846153846153846153846153846153846","total":13,"wicket_id":4}},
         {"wicket":{"data":"08/08/2011","time_release":"0.0723449074074074074074074074074074074074","total":10,"wicket_id":4}},
         {"wicket":{"data":"04/08/2011","time_release":"0.0015329218106995884773662551440329218107","total":9,"wicket_id":4}},
         {"wicket":{"data":"03/08/2011","time_release":"0.00147331154684095860566448801742919389977","total":17,"wicket_id":4}},
         {"wicket":{"data":"02/08/2011","time_release":"0.00496296296296296296296296296296296296295","total":15,"wicket_id":4}},
         {"wicket":{"data":"01/08/2011","time_release":"0.00721331908831908831908831908831908831909","total":26,"wicket_id":4}}]
        JSON

        unless @attendances_per_day.empty?
          format.html
          format.json { render :json => @attendances_per_day.to_json }
        end
      else
        format.html {render :notice => I18n.t('application.no_results')}
        format.json {render :json => nil}
      end
    end
  end
end
