class AddIndexesToCallHistory < ActiveRecord::Migration
  def change
    add_index :call_histories, :ticket_id
    add_index :call_histories, :wicket_id
    add_index :call_histories, :status_ticket_id
    add_index :call_histories, :created_at
  end
end
