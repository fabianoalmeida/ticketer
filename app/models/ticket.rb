class Ticket < ActiveRecord::Base

  include TicketManager

  #String :value
  #Integer :status_ticket
  #Integer :ticket_type
  #Integer :place
  #Integer :totem

  @@actual_value = 0

  belongs_to :status_ticket
  belongs_to :ticket_type
  belongs_to :place
  belongs_to :totem
  
  before_save :generate #:validates_current_date,

  validates :status_ticket, :ticket_type, :place, :totem, :presence => true


  state_machine :initial => :available do 
    
    after_transition any => any, :do => :log_history

    event :call do 
      transition :available => :called 
    end

    event :recall do 
      transition :called => same 
    end

    event :pending do 
      transition :called => :pending
    end
   
    event :reopen do 
      transition :pending => :available 
    end
    
    event :cancel do 
      transition :pending => :canceled
    end
    
    event :attend do 
      transition :called => :attended
    end
  end

  private

  def validates_current_date
    results = Ticket.where( :created_at => Date.today.midnight...Date.tomorrow.midnight, :place_id => self.place  )
    
    if results.size > 0  
        raise "This probaly shouldn't show up for you! :( "
    end
  end

  def generate
    ticket = Ticket.last

    ticket.nil? ? @@actual_value= 1 : @@actual_value= ticket.value.split( ticket.ticket_type.acronym.to_s )[1].to_i + 1

    self.value= self.ticket_type.acronym.to_s + "%04d" % @@actual_value.to_s
  end

end
