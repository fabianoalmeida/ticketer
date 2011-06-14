class Place < ActiveRecord::Base

  #String :value
  #String :user
  #Integer :status
  #Integer :local

  belongs_to :status
  belongs_to :local
  has_many :wickets
  has_many :tickets
  has_many :panels
  has_many :totems
  has_and_belongs_to_many :ticket_type_groups, :uniq => :true

  validates :value, :status, :local, :user, :ticket_type_groups, :presence => true

  accepts_nested_attributes_for :totems, :tickets, :wickets, :panels

  def tickets_called(ticket_type_group= nil) 
    ticket_type_group= ticket_type_group.id if ticket_type_group.is_a? TicketTypeGroup

    calleds = nil

    if ticket_type_group
      calleds = tickets.includes(:ticket_type)
        .where("ticket_types.ticket_type_group_id = #{ticket_type_group}")
        .where(:status_ticket_id => StatusTicket.called.id)
    end

    calleds ||= tickets.where(:status_ticket_id => StatusTicket.called.id)

    calleds
  end

  def tickets_availables(ticket_type_group= nil)
    ticket_type_group= ticket_type_group.id if ticket_type_group.is_a? TicketTypeGroup

    availables = nil

    if ticket_type_group
      availables = tickets.includes(:ticket_type)
        .where("ticket_types.ticket_type_group_id = #{ticket_type_group}")
        .where(:status_ticket_id => StatusTicket.available.id)
    end

    availables ||= tickets.where(:status_ticket_id => StatusTicket.available.id)

    availables
  end
end
