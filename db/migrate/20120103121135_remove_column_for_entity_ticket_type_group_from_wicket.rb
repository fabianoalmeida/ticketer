class RemoveColumnForEntityTicketTypeGroupFromWicket < ActiveRecord::Migration
  def self.up
    ActiveRecord::Base.connection.execute <<-EOS
      INSERT INTO ticket_type_groups_wickets ( ticket_type_group_id, wicket_id )
      SELECT TICKET_TYPE_GROUP_ID, ID FROM wickets
    EOS
    
    remove_column :wickets, :ticket_type_group_id
  end

  def self.down
    change_tabel :wickets do |t| 
      t.references :ticket_type_group, :null => false
    end
  end
end
