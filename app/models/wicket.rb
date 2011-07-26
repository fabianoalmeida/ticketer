class Wicket < ActiveRecord::Base

  #String :value
  #String :user
  #Integer :status
  #Integer :place

  belongs_to :status
  belongs_to :place
  belongs_to :ticket_type_group
  has_many :call_histories
  has_many :tickets, :through => :call_histories, :uniq => :true

  validates :value, :user, :status, :place, :ticket_type_group, :presence => true
  validates_inclusion_of :guidance, :priority, :in => [true, false]

  validates :value,
    :length => { :in => 1..80 },
    :uniqueness => { :case_sensitive => false, :scope => :place_id },
    :allow_blank => false

  def attended_tickets
    tickets.where(:status_ticket_id => StatusTicket.attended.id).order("ticketes.updated_at DESC")
  end

  def called_tickets
    tickets.where(:status_ticket_id => StatusTicket.called.id).order("ticketes.updated_at DESC")
  end

  def pending_tickets
    tickets.where(:status_ticket_id => StatusTicket.pending.id).order("ticketes.updated_at DESC")
  end

  def guidance_left?
    return guidance ? false : true
  end

  def guidance_right?
    return guidance ? true : false
  end

end
