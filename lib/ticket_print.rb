module TicketPrint

  def self.print( ticket )
    escape = 27.chr
    ticket_file = <<-TICKET
      
    #{escape}VHOSPITAL SANTA IZABEL
    #{escape}V#{ticket.place.value}
    #{14.chr} #{ticket.ticket_type.value}
    #{14.chr} #{escape}V#{ticket.value}
    #{escape}V#{I18n.localize( ticket.updated_at, :format => :default) }
    #{escape}J4
    #{escape}w
    TICKET

    File.open("tmp/ticket.txt", "w:ISO-8859-1") do |file|
      file.puts ticket_file
      file.close
    end

    system("smbclient -N //10.30.4.112/Diebold -c 'print tmp/ticket.txt'")
    #system("smbclient -N //10.30.4.112/Diebold -c 'print vendor/escape.txt'")
  end
  
end
