class AddAttachmentsDocumentToWhitePaper < ActiveRecord::Migration
  def self.up
    add_column :white_papers, :document_file_name, :string
    add_column :white_papers, :document_content_type, :string
    add_column :white_papers, :document_file_size, :integer
    add_column :white_papers, :document_updated_at, :datetime
    add_column :white_papers, :document_alt, :string
  end

  def self.down
    remove_column :white_papers, :document_file_name
    remove_column :white_papers, :document_content_type
    remove_column :white_papers, :document_file_size
    remove_column :white_papers, :document_updated_at
    remove_column :white_papers, :document_alt
  end
end
