pdf.image "#{Rails.root}/public/images/hsi-logo-200.jpeg", :width => 100, :heigth => 80

pdf.fill_color "000000"
pdf.text_box "Ticketer", :font => "Georgia, Serif", :size => 40, :at => [354, 709]
pdf.fill_color "C5E008"
pdf.text_box "Ticketer", :font => "Georgia, Serif", :size => 40, :at => [355, 710]

pdf.move_down 30

pdf.fill_color "000000"
pdf.text "#{ t('application.reports.waiting_time_by_client.name') }", :size => 20, :align => :center

pdf.move_down 20

pdf.fill_color "000000"

data = [["#{ t('application.reports.waiting_time_by_client.date') }", 
		 "#{ t('application.reports.waiting_time_by_client.time') }", 
		 "#{ t('application.reports.waiting_time_by_client.quantity') }"] ]

pdf.font_size 10

totalHour = 0
totalTickets = 0
length= @waiting_time_by_client.length

@waiting_time_by_client.each do |call_history|
	current_date = call_history[:data].to_date
    data << [ "#{l(current_date, :format => :default)} (#{l(current_date, :format => '%A')})", 
			  "#{call_history[:time].duration}", 
              call_history[:total]]

    totalHour += call_history[:time]
    totalTickets += call_history[:total]
end

pdf.table(
  data, 
  :header => true, 
  :column_widths => [180, 200, 160], 
  :row_colors => ["F0F0F0", "FFFFFF"]) do

  row(0).style :background_color => '5F9410', :text_color => 'ffffff', :align => :center, :font_style => :bold
  row(1..length).style :align => :center
end

footer = [[ "#{t('application.reports.average')}", 
		   "#{(totalHour / length).duration}" ,
			totalTickets / length
			],
		  [ "#{t('application.reports.total')}", 
		   "#{totalHour.duration}" ,
			totalTickets ]]

pdf.table(
  footer, 
  :column_widths => [180, 200, 160]) do

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
