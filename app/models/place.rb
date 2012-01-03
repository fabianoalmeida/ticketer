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

  def tickets_called(ticket_type_groups= []) 
    calleds = nil

    unless ticket_type_groups.empty?
      calleds = tickets.includes(:ticket_type)
        .where("ticket_types.ticket_type_group_id" => ticket_type_groups)
        .where(:status_ticket_id => StatusTicket.called.id)
    end

    calleds ||= tickets.where(:status_ticket_id => StatusTicket.called.id)

    calleds
  end

  def tickets_availables(ticket_type_groups= [])
    availables = nil

    unless ticket_type_groups.empty?
      availables = tickets.includes(:ticket_type)
        .where("ticket_types.ticket_type_group_id" => ticket_type_groups)
        .where(:status_ticket_id => StatusTicket.available.id)
    end

    availables ||= tickets.where(:status_ticket_id => StatusTicket.available.id)

    availables
  end

  def tickets_attended(ticket_type_groups= [])
    attended = nil

    unless ticket_type_groups.empty?
      attended = tickets.includes(:ticket_type)
        .where("ticket_types.ticket_type_group_id" => ticket_type_groups)
        .where(:status_ticket_id => StatusTicket.attended.id)
    end

    attended ||= tickets.where(:status_ticket_id => StatusTicket.attended.id)

    attended
  end

  def self.actives
    self.where( :status_id => Status.active.id ).order( :value )
  end
end
