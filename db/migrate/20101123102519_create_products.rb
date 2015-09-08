class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|

      t.integer :make_id

      t.integer :category_id

      t.string :name

      t.text :summary

      t.text :description

      t.text :video

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
    drop_table :products
  end
end