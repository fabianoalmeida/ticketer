class Wicket < ActiveRecord::Base

  #String :value
  #String :user
  #Integer :status
  #Integer :place

  belongs_to :status
  belongs_to :place
  has_many :call_histories
  has_many :tickets, :through => :call_histories, :uniq => :true

  validates :value, :user, :status, :place, :presence => true
  validates_inclusion_of :guidance, :priority, :in => [true, false]

  validates :value,
    :length => { :in => 1..80 },
    :uniqueness => { :case_sensitive => false },
    :allow_blank => false
  
  def called_tickets
    tickets.where(:status_ticket_id => StatusTicket.called.id).order("updated_at DESC")
  end
  
  def pending_tickets
    tickets.where(:status_ticket_id => StatusTicket.pending.id).order("updated_at DESC")
  end

  def guidance_left?
    return guidance ? false : true
  end

  def guidance_right?
    return guidance ? true : false
  end

end
