class AddServiceIdToTestimonials < ActiveRecord::Migration
  
  def self.up
    add_column :testimonials, :service_id, :integer
  end

  def self.down
    remove_column :testimonials, :service_id
  end
  
end
