module TicketPrint

  def self.print( ticket )
    place_id = ticket.place.id
    totem    = ticket.totem

    template = ticket.totem.printer.template
    template = template.gsub("escape", 27.chr)
    template = template.gsub("shift_out", 14.chr)
    template = template.gsub("ticket_place_value", ticket.place.value)
    template = template.gsub("ticket_ticket_type_value", ticket.ticket_type.value)
    template = template.gsub("ticket_value", ticket.value)
    template = template.gsub("current_date_formated", I18n.localize(ticket.updated_at, :format => :default))
   
    File.open("tmp/place_id_#{place_id}.txt", "w:UTF-8") do |file|
      file.puts template
      file.close
    end

    system("smbclient -N //#{totem.ip}/Diebold -c 'print tmp/place_id_#{place_id}.txt'")
  end
  
end
