class CreateCallHistories < ActiveRecord::Migration
  def self.up
    create_table :call_histories do |t|

      t.references :ticket, :null => false
      t.references :wicket, :null => false
      t.references :call_history_type, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :call_histories
  end
end
