module TicketPrint

  def self.print( ticket )
    escape = 27.chr
    totem = ticket.totem
    ticket_file = <<-TICKET
            #{escape}VHOSPITAL SANTA IZABEL
            #{escape}V#{ticket.place.value}

            #{14.chr} #{ticket.ticket_type.value}
            #{14.chr} #{escape}V#{ticket.value}

          #{escape}V#{I18n.localize( ticket.updated_at, :format => :default) }
    #{escape}J4
    #{escape}w
    TICKET

    File.open("tmp/ticket.txt", "w:UTF-8") do |file|
      file.puts ticket_file
      file.close
    end

    system("smbclient -N //#{totem.ip}/Diebold -c 'print tmp/ticket.txt'")
  end

end
