class Ticket < ActiveRecord::Base

  attr_accessor :current_wicket, :priority
  include TicketManager
  include TicketerIo

  #String :value
  #Integer :status_ticket
  #Integer :ticket_type
  #Integer :place
  #Integer :totem

  @@actual_value = 0

  belongs_to :status_ticket
  belongs_to :ticket_type
  belongs_to :place
  belongs_to :totem
  has_many :call_histories
  has_many :wickets, :through => :call_histories

  before_save :generate

  validates :status_ticket, :ticket_type, :place, :totem, :presence => true

  self.after_initialize do
    self.status_ticket = StatusTicket.available if self.new_record?
    self.priority = self.ticket_type.priority if self.ticket_type
  end

  def self.calleds_from_place(place)
    call = CallHistory.arel_table
    tick = self.arel_table
    Ticket.joins(:call_histories).where(tick[:place_id].eq(place).and(call[:status_ticket_id].eq(StatusTicket.called.id)))
  end

  def last_wicket_to_call
    self.wickets.last
  end
#select avg(strftime('%s', attended.created_at) - strftime('%s', called.created_at)) as avg_time from tickets t join (select ch.ticket_id, max( ch.created_at ) as created_at from call_histories ch where ch.status_ticket_id = 1 group by ch.ticket_id) called on called.ticket_id = t.id join
  #(select ch.ticket_id, max( ch.created_at ) as created_at from call_histories ch where ch.status_ticket_id = 3 group by ch.ticket_id) attended
  #on attended.ticket_id = t.id;
  #
  # Trying Arel below:
  # CallHistory.where( arel_call[:status_ticket_id].eq(3) ).group(arel_call[:ticket_id]).select( arel_call[:created_at].maximum ).project(arel_call[:ticket_id])

  state_machine :initial => :available do

    event :call do
      transition :available => :called
    end

    event :recall do
      transition :called => same
    end

    event :pending do
      transition :called => :pending
    end

    event :reopen do
      transition :pending => :available
    end

    event :cancel do
      transition :pending => :canceled
    end

    event :attend do
      transition :called => :attended
    end
  end

  private

  def generate
    if new_record?
      ticket = Ticket.where(:place_id => place.id).today.last
      if ticket.nil?
        @@actual_value= 1
        self.emit_reload_panel
      else
        @@actual_value= ticket.value.split( ticket.ticket_type.acronym.to_s )[1].to_i + 1
      end
      self.value= self.ticket_type.acronym.to_s + "%04d" % @@actual_value.to_s
    end
  end

end
