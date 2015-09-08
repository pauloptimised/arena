class AddAttachmentsInformationPackToJob < ActiveRecord::Migration
  
  def self.up
    add_column :jobs, :information_pack_file_name,    :string
    add_column :jobs, :information_pack_content_type, :string
    add_column :jobs, :information_pack_file_size,    :integer
    add_column :jobs, :information_pack_updated_at,   :datetime
    add_column :jobs, :information_pack_alt,          :string
  end
  
  def self.down
    remove_column :jobs, :information_pack_file_name
    remove_column :jobs, :information_pack_content_type
    remove_column :jobs, :information_pack_file_size
    remove_column :jobs, :information_pack_updated_at
    remove_column :jobs, :information_pack_alt
  end
  
end
