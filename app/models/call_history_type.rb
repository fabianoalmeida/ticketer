class CallHistoryType < ActiveRecord::Base

  #String :value
  #String :acronym
  #String :user

  has_many :call_histories

  validates :value, :acronym, :user, :presence => { :message => "is required!" }

  validates :value, 
    :length => { :in => 1..80 },
    :uniqueness => { :message => "already exists!", :case_sensitive => false },
    :allow_blank => false

  validates :acronym, 
    :length => { :maximum => 3 },
    :uniqueness => { :message => "already exists!", :case_sensitive => false },
    :allow_blank => false

  def self.called
    self.where( :value => "Called" ).first    
  end

  def self.canceled
    self.where( :value => "Canceled" ).first    
  end

  def self.released
    self.where( :value => "Released" ).first    
  end

  def self.attended
    self.where( :value => "Attended" ).first    
  end

end
