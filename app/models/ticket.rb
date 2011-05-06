class Ticket < ActiveRecord::Base

  attr_accessor :current_wicket
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
  has_many :call_histories
  has_many :wickets, :through => :call_histories
  
  before_save :generate #:validates_current_date,

  validates :status_ticket, :ticket_type, :place, :totem, :presence => true

  self.after_initialize do
    self.status_ticket = StatusTicket.available if self.new_record?
  end

  state_machine :initial => :available do 

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
    if new_record?
      ticket = Ticket.last
      ticket.nil? ? @@actual_value= 1 : @@actual_value= ticket.value.split( ticket.ticket_type.acronym.to_s )[1].to_i + 1
      self.value= self.ticket_type.acronym.to_s + "%04d" % @@actual_value.to_s
    end
  end

end
