class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|

      t.string :name

      t.text :summary

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
    drop_table :categories
  end
end