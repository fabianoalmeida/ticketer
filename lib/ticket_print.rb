module TicketPrint

  def self.print( ticket )
    ticket_file = <<-TICKET





          HOSPITAL SANTA IZABEL
          #{ticket.place.value}
          #{ticket.ticket_type.value}
          #{ticket.value}
          #{ticket.updated_at}



    TICKET

    File.open("tmp/ticket.txt", "w:ISO-8859-1") do |file|
      file.puts ticket_file
      file.close
    end

    system("smbclient -N //10.30.4.112/Diebold -c 'print tmp/ticket.txt'")
    system("smbclient -N //10.30.4.112/Diebold -c 'print vendor/escape.txt'")
  end
  
end
