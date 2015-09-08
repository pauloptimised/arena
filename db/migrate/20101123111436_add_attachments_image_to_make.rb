class AddAttachmentsImageToMake < ActiveRecord::Migration
  def self.up
    add_column :makes, :image_file_name, :string
    add_column :makes, :image_content_type, :string
    add_column :makes, :image_file_size, :integer
    add_column :makes, :image_updated_at, :datetime
    add_column :makes, :image_alt, :string
  end

  def self.down
    remove_column :makes, :image_file_name
    remove_column :makes, :image_content_type
    remove_column :makes, :image_file_size
    remove_column :makes, :image_updated_at
    remove_column :makes, :image_alt
  end
end
