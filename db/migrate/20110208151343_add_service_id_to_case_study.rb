class AddServiceIdToCaseStudy < ActiveRecord::Migration
  def self.up
    add_column :case_studies, :service_id, :integer
  end

  def self.down
    remove_column :case_studies, :service_id
  end
end
