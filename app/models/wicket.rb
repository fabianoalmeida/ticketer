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
  validates_inclusion_of :guidance, :priority, :second_level, :in => [true, false]

  validates :value,
    :length => { :in => 1..80 },
    :uniqueness => { :case_sensitive => false, :scope => :place_id },
    :allow_blank => false

  def self.tickets_by_status(*args) 
    args.each do |status| 
      instance_eval do 
        define_method "#{status}_tickets" do
          tickets.where(:status_ticket_id => StatusTicket.id_for("#{status.to_s}").id).order("tickets.updated_at DESC")
        end 
      end
    end
  end    

  tickets_by_status :attended, :called, :pending, :examed

  def guidance_left?
    return guidance ? false : true
  end

  def guidance_right?
    return guidance ? true : false
  end

end
