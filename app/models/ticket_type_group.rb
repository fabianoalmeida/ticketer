class TicketTypeGroup < ActiveRecord::Base

  belongs_to :status
  has_and_belongs_to_many :places
  has_and_belongs_to_many :wickets

  validates :value, :user, :status, :presence => true

  validates :value, 
    :length => { :maximum => 80 },
    :uniqueness => { :case_sensitive => false }

  def ticket_types
    TicketType.where(:ticket_type_group_id => self.id)
  end
  
  def self.tokens(query)
    ticket_type_groups = where{ upper(value) =~ "%#{query.upcase}%" }
    if ticket_type_groups.empty?
      [ { id: "<<<#{query}>>>", value: "Novo \"#{query.capitalize}\"" } ]
    else
      ticket_type_groups
    end
  end

  def self.ids_from_tokens(tokens)
    tokens.gsub!(/<<<(.+?)>>>/) { create!(value: $1.capitalize, status: Status.active, user: 'user test').id }
    tokens.split(',')
  end
end
