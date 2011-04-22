class CreateCallHistories < ActiveRecord::Migration
  def self.up
    create_table :call_histories do |t|

      t.references :ticket, :null => false
      t.references :wicket, :null => false
      t.references :status_ticket, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :call_histories
  end
end
