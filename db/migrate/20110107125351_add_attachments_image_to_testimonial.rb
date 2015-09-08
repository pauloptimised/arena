class AddAttachmentsImageToTestimonial < ActiveRecord::Migration
  def self.up
    add_column :testimonials, :image_file_name, :string
    add_column :testimonials, :image_content_type, :string
    add_column :testimonials, :image_file_size, :integer
    add_column :testimonials, :image_updated_at, :datetime
    add_column :testimonials, :image_alt, :string
  end

  def self.down
    remove_column :testimonials, :image_file_name
    remove_column :testimonials, :image_content_type
    remove_column :testimonials, :image_file_size
    remove_column :testimonials, :image_updated_at
    remove_column :testimonials, :image_alt
  end
end
