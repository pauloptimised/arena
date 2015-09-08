class CreateStaffTestimonials < ActiveRecord::Migration
  
  def self.up
    create_table :staff_testimonials do |t|
      t.text       :quote
      t.string     :author
      t.integer    :created_by
      t.integer    :updated_by
      t.boolean    :recycled, :default => false
      t.datetime   :recycled_at
      t.boolean    :display, :default => true
      t.integer    :position, :default => 0
      t.timestamps
    end
  end
  
  def self.down
    drop_table :staff_testimonials
  end
  
end
