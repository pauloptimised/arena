class AddLinkToHomeHighlights < ActiveRecord::Migration
  def self.up
    add_column :home_highlights, :external_link, :string
    add_column :home_highlights, :external_link_new_window, :boolean, :default => true
  end

  def self.down
    remove_column :home_highlights, :external_link_new_window
    remove_column :home_highlights, :external_link
  end
end
