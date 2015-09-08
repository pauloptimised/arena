class AddAttachmentsImageToProduct < ActiveRecord::Migration
  def self.up
    add_column :products, :image_file_name, :string
    add_column :products, :image_content_type, :string
    add_column :products, :image_file_size, :integer
    add_column :products, :image_updated_at, :datetime
    add_column :products, :image_alt, :string
  end

  def self.down
    remove_column :products, :image_file_name
    remove_column :products, :image_content_type
    remove_column :products, :image_file_size
    remove_column :products, :image_updated_at
    remove_column :products, :image_alt
  end
end
