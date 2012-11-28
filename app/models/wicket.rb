class Wicket < ActiveRecord::Base
  extend FriendlyId
  
  friendly_id :value, use: :slugged

  #String :value
  #String :user
  #Integer :status
  #Integer :place

  belongs_to :status
  belongs_to :place
  has_many :call_histories
  has_many :tickets, :through => :call_histories, :uniq => :true
  has_and_belongs_to_many :ticket_type_groups, :uniq => :true
  has_and_belongs_to_many :reference_groups, 
                          :class_name => "TicketTypeGroup",
                          :foreign_key => "wicket_id",
                          :join_table => "reference_groups_wickets"

  validates :value, :user, :status, :place, :ticket_type_groups, :presence => true
  validates_inclusion_of :guidance, :priority, :second_level, :alternate, :in => [true, false]

  validates :value,
    :length => { :in => 1..80 },
    :uniqueness => { :case_sensitive => false, :scope => :place_id },
    :allow_blank => false

  validate :validate_reference_groups

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
  
  def validate_reference_groups
    reference_groups.each do |rg|
      errors.add :reference_groups, "#{rg.value} ja esta como um tipo de senha" if ticket_type_groups.include?(rg)
    end
  end

  def guidance_left?
    return guidance ? false : true
  end

  def guidance_right?
    return guidance ? true : false
  end
  
  def has_reference?
    !reference_groups.empty?
  end
  
  def ticket_types
    values = []
    ticket_type_groups.order("value ASC").each do |ttg|
      values << ttg.value
    end
    values.join(", ")
  end
    
  def references
    values = []
    reference_groups.order("value ASC").each do |rg|
      values << rg.value
    end
    values.join(", ")
  end

end
