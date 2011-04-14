class Ticket < ActiveRecord::Base

  #String :value
  #Integer :status_ticket_id
  #Integer :ticket_type_id

  @@actual_value = 0

  belongs_to :status_ticket
  belongs_to :ticket_type
  #belongs_to :place
  
  before_save :validates_current_date, :generate

  validates :status_ticket, :ticket_type, :presence => { :message => "is required!" }

  private

  def validates_current_date
    results = Ticket.where( :created_at => Date.today.midnight...Date.tomorrow.midnight, #:place => self.place, 
                           :value => self.value )
    
    if results.size > 0  
        raise error
    end
  end

  def generate
    ticket = Ticket.last

    ticket.nil? ? @@actual_value= 1 : @@actual_value+= 1

    self.value= self.ticket_type.acronym.to_s + "%04d" % @@actual_value.to_s
  end

end
