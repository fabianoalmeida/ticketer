class CallHistory < ActiveRecord::Base

  #Integer :ticket
  #Integer :wicket
  #Integer :status_ticket

  belongs_to :ticket
  belongs_to :wicket
  belongs_to :status_ticket

  validates :ticket, :wicket, :status_ticket, :presence => true

  def self.register(record={})
    return false if record.empty?
    new_record = self.new(:ticket => record[:ticket], :status_ticket => record[:ticket].status_ticket, :wicket => record[:wicket])
    new_record.save

  end
    
  def self.today
    where(:created_at => Date.today.midnight...Date.tomorrow.midnight)
  end
end
