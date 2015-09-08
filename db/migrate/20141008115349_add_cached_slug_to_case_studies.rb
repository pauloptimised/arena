class AddCachedSlugToCaseStudies < ActiveRecord::Migration
  def self.up
    add_column :case_studies, :cached_slug, :string
  end

  def self.down
    remove_column :case_studies, :cached_slug
  end
end
