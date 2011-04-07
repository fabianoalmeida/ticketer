class Ticket < ActiveRecord::Base

  #String :value
  #Integer :status_ticket_id
  #Integer :ticket_type_id
  
  before_save :validates_current_date

  validates :value, :presence => { :message => "is required!" }

  validates :value, 
    :length => { :minimum => 1, :maximum => 80 },
    :uniqueness => { :message => "already exists!" }, 
    :unless => lambda{ self.value.blank? } 

  has_one :status_ticket
  has_one :ticket_type

  private

  def validates_current_date
    results = Ticket.where( :created_at => Date.today.midnight..Date.tomorrow.midnight, :value => self.value )
    
    if results.size > 0  
        raise error
    end
  end

end
