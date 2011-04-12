class Ticket < ActiveRecord::Base

  #String :value
  #Integer :status_ticket_id
  #Integer :ticket_type_id

  belongs_to :status_ticket
  belongs_to :ticket_type
  belongs_to :place
  
  before_save :validates_current_date

  validates :value, :status_ticket, :ticket_type, :presence => { :message => "is required!" }

  validates :value, 
    :length => { :minimum => 1, :maximum => 80 },
    :uniqueness => { :message => "already exists!" }, 
    :unless => lambda{ self.value.blank? } 

  private

  def validates_current_date
    results = Ticket.where( :created_at => Date.today.midnight...Date.tomorrow.midnight, :place => self.place, :value => self.value )
    
    if results.size > 0  
        raise error
    end
  end

end
