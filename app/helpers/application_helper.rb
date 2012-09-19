module ApplicationHelper
  
  def unabbreviated_month(month)
    (I18n.t('date.month_names'))[month]
  end
  
  def unabbreviated_month_year(month_year)
    arr       = (month_year.to_s).split('/')
    month_int = arr[0].to_i
    year_int  = arr[1].to_i
    "#{(I18n.t('date.month_names'))[month_int]} / #{year_int}"
  end
  
  def javascript_include_juggernaut
    url = Rails.env.production? ? "ticketer.hsi.scmba.com.br" : "localhost"
    javascript_include_tag("http://#{url}:8080/application.js")
  end

end
