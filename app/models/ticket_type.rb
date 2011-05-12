class TicketType < ActiveRecord::Base

  #String :value
  #String :acronym
  #String :user
  #Integer :status

  belongs_to :status
  has_many :tickets
  has_and_belongs_to_many :places

  validates :value, :acronym, :user, :status, :presence => true
  validates_inclusion_of :priority, :in => [true, false]

  validates :value, 
    :length => { :in => 1..80 },
    :uniqueness => { :case_sensitive => false },
    :allow_blank => false

  validates :acronym, 
    :length => { :maximum => 3 },
    :uniqueness => { :case_sensitive => false },
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

  def self.priorities 
    self.where(:priority => true)
  end
end
