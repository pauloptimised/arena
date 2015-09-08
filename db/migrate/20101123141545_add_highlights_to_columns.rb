class AddHighlightsToColumns < ActiveRecord::Migration
  def self.up
    add_column :articles, :highlight, :boolean
    add_column :case_studies, :highlight, :boolean
    add_column :products, :highlight, :boolean
    add_column :testimonials, :highlight, :boolean
  end

  def self.down
    remove_column :articles, :highlight
    remove_column :case_studies, :highlight
    remove_column :products, :highlight
    remove_column :testimonials, :highlight
  end
end
