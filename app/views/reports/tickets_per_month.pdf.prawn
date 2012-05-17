pdf.image "#{Rails.root}/app/assets/images/hsi-logo-200.jpeg", :width => 100, :heigth => 80

pdf.fill_color "000000"
pdf.text_box "Ticketer", :font => "Georgia, Serif", :size => 40, :at => [354, 709]
pdf.fill_color "C5E008"
pdf.text_box "Ticketer", :font => "Georgia, Serif", :size => 40, :at => [355, 710]

pdf.move_down 30

pdf.fill_color "000000"
pdf.text "#{ t('application.reports.tickets_per_month.name') }", :size => 20, :align => :center

pdf.move_down 20

pdf.fill_color "000000"

data ||= [ ["#{ t('application.reports.tickets_per_month.month_year') }", "#{ t('application.reports.tickets_per_month.quantity') }"] ]

pdf.font_size 10

total= 0
length= @tickets_per_month.length

@tickets_per_month.each do |ticket|
  data << [ unabbreviated_month_year(ticket.date_local), ticket.count_id ]
  total += ticket.count_id
end

pdf.table(
  data, 
  :header => true, 
  :column_widths => [270, 270], 
  :row_colors => ["F0F0F0", "FFFFFF"]) do

  row(0).style :background_color => '5F9410', :text_color => 'ffffff', :align => :center, :font_style => :bold
  row(1..length).style :align => :center
end

footer ||= []
footer << [ "#{t('application.reports.average')}", total / length ]
footer << [ "#{t('application.reports.total')}", total ]

pdf.table(
  footer, 
  :column_widths => [270, 270]) do

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
