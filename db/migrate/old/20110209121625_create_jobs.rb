class CreateJobs < ActiveRecord::Migration
  
  def self.up
    create_table :jobs do |t|
      t.string      :name
      t.text        :summary
      t.text        :main_content
      t.date        :closing_date
      t.integer     :created_by
      t.integer     :updated_by
      t.boolean     :recycled,    :default => false
      t.datetime    :recycled_at
      t.boolean     :display,     :default => true
      t.integer     :position,    :default => 0
      t.timestamps
    end
  end
  
  def self.down
    drop_table :jobs
  end
  
end