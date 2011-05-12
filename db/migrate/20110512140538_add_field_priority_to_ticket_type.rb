class AddFieldPriorityToTicketType < ActiveRecord::Migration
  def self.up
    add_column :ticket_types, :priority, :boolean 
  end

  def self.down
    remove_column :ticket_types, :priority, :boolean 
  end
end
