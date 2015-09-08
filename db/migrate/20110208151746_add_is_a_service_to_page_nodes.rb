class AddIsAServiceToPageNodes < ActiveRecord::Migration
  def self.up
    add_column :page_nodes, :is_a_service, :boolean
  end

  def self.down
    remove_column :page_nodes, :is_a_service
  end
end
