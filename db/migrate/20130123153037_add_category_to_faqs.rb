class AddCategoryToFaqs < ActiveRecord::Migration
  
  def self.up
    add_column :faqs, :category, :string, :after => :answer
  end
  
  def self.down
    remove_column :faqs, :category
  end
  
end
