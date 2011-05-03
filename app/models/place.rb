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
  has_and_belongs_to_many :ticket_types

  validates :value, :status, :local, :user, :ticket_types, :presence => true

  accepts_nested_attributes_for :totems, :tickets, :wickets, :panels

  def tickets_called 
    tickets.where(:status_ticket_id => StatusTicket.called.id)
  end

  def tickets_availables
    tickets.where(:status_ticket_id => StatusTicket.available.id)
  end
end
