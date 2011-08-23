pdf.image "#{Rails.root}/public/images/hsi-logo-200.jpeg", :width => 100, :heigth => 80

pdf.fill_color "000000"
pdf.text_box "Ticketer", :font => "Georgia, Serif", :size => 40, :at => [354, 709]
pdf.fill_color "C5E008"
pdf.text_box "Ticketer", :font => "Georgia, Serif", :size => 40, :at => [355, 710]

pdf.move_down 30

pdf.fill_color "000000"
pdf.text "#{ t('application.reports.tickets_per_day.name') }", :size => 20, :align => :center

pdf.move_down 20

pdf.fill_color "000000"

data ||= [ ["#{ t('application.reports.tickets_per_day.date') }", "#{ t('application.reports.tickets_per_day.quantity') }"] ]

@tickets_per_day.each do |ticket|
  data << [ ticket.date_local, ticket.count_id ]
end

pdf.table(
  data, 
  :header => true, 
  :column_widths => [270, 270], 
  :row_colors => ["F0F0F0", "FFFFCC"]
)

pdf.fill_color "000000"
pdf.text_box "#{ l(DateTime.now, :format => :default) }", :size => 10, :at => [0, 15]
