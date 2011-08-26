pdf.image "#{Rails.root}/public/images/hsi-logo-200.jpeg", :width => 100, :heigth => 80

pdf.fill_color "000000"
pdf.text_box "Ticketer", :font => "Georgia, Serif", :size => 40, :at => [354, 709]
pdf.fill_color "C5E008"
pdf.text_box "Ticketer", :font => "Georgia, Serif", :size => 40, :at => [355, 710]

pdf.move_down 30

pdf.fill_color "000000"
pdf.text "#{ t('application.reports.attendances_by_wickets_per_day.name') }", :size => 20, :align => :center

pdf.move_down 20

pdf.fill_color "000000"

data = [ [ t('activerecord.models.wicket').to_s, t('application.reports.attendances_by_wickets_per_day.date').to_s,  t('application.reports.attendances_by_wickets_per_day.quantity').to_s ] ]

pdf.font_size 10

total= 0
length= 0

@attendances_per_day.each do |call_history|
  call_history[1].values[0].each_with_index do |val, index|
	current_date = call_history[1][:dates][index].to_date
    data << [ index == 0 ? call_history[0].to_s : "", "#{l(current_date, :format => :default)} (#{l(current_date, :format => '%A')})", val.to_s ]
    total += val
	length += 1
  end
end

pdf.table(
  data, 
  :header => true, 
  :column_widths => [180, 180, 180], 
  :row_colors => ["F0F0F0", "FFFFFF"]) do

  row(0).style :background_color => '5F9410', :text_color => 'ffffff', :align => :center, :font_style => :bold
  row(1..length).style :align => :center
end

footer = []
footer << [ "", "#{t('application.reports.average')}", total / length ]
footer << [ "", "#{t('application.reports.total')}", total ]

pdf.table(
  footer, 
  :column_widths => [180, 180, 180]) do

  row(0).style :background_color => 'B2C430', :text_color => 'ffffff', :align => :center, :font_style => :bold
  row(0).columns(0).style :align => :right
  row(1).style :background_color => '5F9410', :text_color => 'ffffff', :align => :center, :font_style => :bold
  row(1).columns(0).style :align => :right
end

pdf.fill_color "000000"
pdf.text_box "#{ l(DateTime.now, :format => :default) }", :size => 10, :at => [0, 15]

pdf.repeat(:all, :dynamic => true) do
  pdf.draw_text pdf.page_number, :at => [550, 0]
end
