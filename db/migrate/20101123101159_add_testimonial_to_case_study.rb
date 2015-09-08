class AddTestimonialToCaseStudy < ActiveRecord::Migration
  def self.up
    add_column :case_studies, :testimonial_id, :integer
  end

  def self.down
    remove_column :case_studies, :testimonial_id
  end
end
