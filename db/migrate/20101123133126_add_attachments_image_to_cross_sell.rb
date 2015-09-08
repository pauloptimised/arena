class AddAttachmentsImageToCrossSell < ActiveRecord::Migration
  def self.up
    add_column :cross_sells, :image_file_name, :string
    add_column :cross_sells, :image_content_type, :string
    add_column :cross_sells, :image_file_size, :integer
    add_column :cross_sells, :image_updated_at, :datetime
    add_column :cross_sells, :image_alt, :string
  end

  def self.down
    remove_column :cross_sells, :image_file_name
    remove_column :cross_sells, :image_content_type
    remove_column :cross_sells, :image_file_size
    remove_column :cross_sells, :image_updated_at
    remove_column :cross_sells, :image_alt
  end
end
