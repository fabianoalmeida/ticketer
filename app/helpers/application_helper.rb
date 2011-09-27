module ApplicationHelper
  
  def unabbreviated_month(month)
    (I18n.t('date.month_names'))[month]
  end
  
  def unabbreviated_month_year(month_year)
    arr       = month_year.split('/')
    month_int = arr[0].to_i
    year_int  = arr[1].to_i
    "#{(I18n.t('date.month_names'))[month_int]} / #{year_int}"
  end

end
