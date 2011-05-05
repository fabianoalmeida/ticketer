class Wicket < ActiveRecord::Base

  #String :value
  #String :user
  #Integer :guidance
  #Integer :status
  #Integer :place

  belongs_to :status
  belongs_to :place
  has_many :call_histories
  has_many :tickets, :through => :call_histories

  validates :value, :user, :guidance, :status, :place, :presence => true

  validates :value,
    :length => { :in => 1..80 },
    :uniqueness => { :case_sensitive => false },
    :allow_blank => false
  
  def called_tickets
    tickets.where(:status_ticket_id => StatusTicket.called.id)
  end
  
  def pending_tickets
    tickets.where(:status_ticket_id => StatusTicket.pending.id)
  end

  def guidance_left?
    return true unless guidance     
  end

  def guidance_right?
    return true if guidance
  end

end
