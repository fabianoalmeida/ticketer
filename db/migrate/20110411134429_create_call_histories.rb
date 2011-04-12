class CreateCallHistories < ActiveRecord::Migration
  def self.up
    create_table :call_histories do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :call_histories
  end
end
