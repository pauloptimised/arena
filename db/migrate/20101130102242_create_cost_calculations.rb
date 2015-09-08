class CreateCostCalculations < ActiveRecord::Migration
  def self.up
    create_table :cost_calculations do |t|

      t.integer :no_documents_to_file

      t.integer :no_documents_looked_for

      t.integer :no_ring_backs

      t.integer :copies_posted

      t.float :staff_rate_per_hour

      t.float :phone_call_cost

      t.float :average_print_postal_cost

      t.timestamps
      t.integer :created_by
      t.integer :updated_by
      t.boolean :recycled, :default => false
      t.datetime :recycled_at
      t.boolean :display, :default => true
      t.integer :position, :default => 0
    end
  end
  
  def self.down
    drop_table :cost_calculations
  end
end