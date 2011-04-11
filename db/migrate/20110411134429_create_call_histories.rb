class CreateCallHistories < ActiveRecord::Migration
  def self.up
    create_table :call_histories do |t|
      t.integer :ticket_id
      t.integer :wicket_id
      t.integer :call_history_type_id

      t.timestamps
    end
  end

  def self.down
    drop_table :call_histories
  end
end
