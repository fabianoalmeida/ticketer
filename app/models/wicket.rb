class Wicket < ActiveRecord::Base

  #String :value
  #String :user
  #Integer :status
  #Integer :place

  belongs_to :status
  belongs_to :place
  has_many :call_histories
  has_many :tickets, :through => :call_histories, :uniq => :true
  has_and_belongs_to_many :ticket_type_groups, :uniq => :true

  validates :value, :user, :status, :place, :ticket_type_groups, :presence => true
  validates_inclusion_of :guidance, :priority, :second_level, :alternate, :in => [true, false]

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
  
  def ticket_types
    values = []
    ticket_type_groups.order("value ASC").each do |ttg|
      values << ttg.value
    end
    values.join(", ")
  end

end
