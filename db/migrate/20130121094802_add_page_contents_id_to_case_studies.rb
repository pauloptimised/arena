class AddPageContentsIdToCaseStudies < ActiveRecord::Migration
  def self.up
    add_column :case_studies, :page_content_id, :integer
  end

  def self.down
    remove_column :case_studies, :page_content_id
  end
end
