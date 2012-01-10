class TicketType < ActiveRecord::Base

  #String :value
  #String :acronym
  #String :user
  #Integer :status

  belongs_to :status
  belongs_to :ticket_type_group
  has_many :tickets

  validates :value, :acronym, :user, :status, :ticket_type_group, :presence => true
  validates_inclusion_of :priority, :in => [true, false]

  validates :value, 
    :length => { :in => 1..80 },
    :uniqueness => { :case_sensitive => false, :scope => :ticket_type_group_id },
    :allow_blank => false

  validates :acronym, 
    :length => { :maximum => 3 },
    :uniqueness => { :case_sensitive => false, :scope => :ticket_type_group_id },
    :allow_blank => false

  def self.preferencial 
    self.where(:acronym => "PRE").first
  end

  def self.normal 
    self.where(:acronym => "NOR").first
  end

  def self.attendance 
    self.where(:acronym => "ATT").first
  end

  def self.priorities(ticket_type_groups= [])
    priorities = nil
    
    unless ticket_type_groups.empty?
      priorities = self.where(:priority => true, :ticket_type_group_id => ticket_type_groups)
    end

    priorities ||= self.where(:priority => true)

    priorities
  end
end
