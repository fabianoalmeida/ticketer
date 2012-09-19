pdf.image "#{Rails.root}/app/assets/images/hsi-logo-200.jpeg", :width => 100, :heigth => 80

pdf.fill_color "000000"
pdf.text_box "Ticketer", :font => "Georgia, Serif", :size => 40, :at => [354, 709]
pdf.fill_color "C5E008"
pdf.text_box "Ticketer", :font => "Georgia, Serif", :size => 40, :at => [355, 710]

pdf.move_down 30

pdf.fill_color "000000"
pdf.text "#{ t('application.reports.waiting_time_by_month_per_wicket.name') }", :size => 20, :align => :center

pdf.move_down 20

pdf.fill_color "000000"

data = [["#{ t('activerecord.models.wicket') }",
 			"#{ t('application.reports.waiting_time_by_month_per_wicket.month_year') }", 
			"#{t('application.reports.waiting_time_by_month_per_wicket.time')}",
			"#{ t('application.reports.waiting_time_by_month_per_wicket.total') }"] ]

pdf.font_size 10

totalTimes   = 0
totalTickets = 0
length       = 0

@wickets_per_month.each do |call_history|
  length += call_history[1].size
  call_history[1].each_with_index do |val, index|
    data << [  index == 0 ? unabbreviated_month_year(call_history[0]) : "", 
			  call_history[1][index][:wicket_name], 
			  "#{call_history[1][index][:time].duration}", 
			  val[:total] ]
    totalTimes += call_history[1][index][:time]
    totalTickets += val[:total]
  end
end

pdf.table(
  data, 
  :header => true, 
  :column_widths => [130, 140, 160, 100], 
  :row_colors => ["F0F0F0", "FFFFFF"]) do

  row(0).style :background_color => '5F9410', :text_color => 'ffffff', :align => :center, :font_style => :bold
  row(1..length).style :align => :center
end

footer = [["", 
		   "#{t('application.reports.average')}", 
		   "#{(totalTimes / length).duration}" ,
			totalTickets / length 
			],
 		   ["",
 		   "#{t('application.reports.total')}", 
			"#{totalTimes.duration}",
			totalTickets ]]

pdf.table(
  footer, 
  :column_widths => [130, 140, 160, 100]) do

  row(0).style :background_color => 'B2C430', :text_color => 'ffffff', :align => :center, :font_style => :bold
  row(0).columns(0).style :align => :right
  row(1).style :background_color => '5F9410', :text_color => 'ffffff', :align => :center, :font_style => :bold
  row(1).columns(0).style :align => :right
end

pdf.fill_color "000000"
pdf.text_box "#{ l(DateTime.now, :format => :default) }", :size => 10, :at => [0, 15]

pdf.repeat(:all, :dynamic => true) do
  pdf.draw_text pdf.page_number, :at => [500, 0]
end
