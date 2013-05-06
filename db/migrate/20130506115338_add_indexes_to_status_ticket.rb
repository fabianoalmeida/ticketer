class AddIndexesToStatusTicket < ActiveRecord::Migration
  def change
    add_index :status_tickets, :value
    add_index :status_tickets, :acronym
  end
end
