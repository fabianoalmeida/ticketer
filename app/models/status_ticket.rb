class StatusTicket < ActiveRecord::Base

  #String :value
  #String :acronym
  #String :user

  has_many :tickets

  validates :value, :acronym, :user, :presence => true

  validates :acronym, 
    :length => { :maximum => 3 }, 
    :uniqueness => { :case_sensitive => false },
    :allow_blank => false

  validates :value, 
    :length => { :in => 1..80 }, 
    :uniqueness => { :case_sensitive => false },
    :allow_blank => false

  def self.statuses(*args) 
    args.each do |status| 
      instance_eval do 
        define_singleton_method status do
          self.where( :value => "#{status.to_s.capitalize}" ).first
        end 
      end
    end
  end    

  statuses :available, :called, :pending, :canceled, :attended, :examed

  def self.id_for(state_string)
    self.where("lower(value) = ?", state_string.downcase).first
  end
end
