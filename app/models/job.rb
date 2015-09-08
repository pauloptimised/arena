class Job < ActiveRecord::Base
	
	acts_as_eskimagical
  
	named_scope :position,     :order => "position"
  named_scope :active,       lambda{{:conditions => ["recycled = ? AND display = ? AND closing_date > ?", false, true, Date.today]}}
  named_scope :recycled,     :conditions => ["recycled = ?", true]
  named_scope :unrecycled,   :conditions => ["recycled = ?", false]
  
  has_attached_document :information_pack
  has_documents
  
  validates_presence_of :name, :main_content, :closing_date
  
  def active?
  	display? && !recycled? && closing_date > Date.today
  end
  
  # each model should have a name method, if name is not in the db and a summary method, if summary is not in the db
  # this is used for searching the models
  
  # if you want to tweak the searching for a model define search_string_1, search_string_2 and search_string_3
  # these default to name, summary and attributes, higher number, higher in the search
  
end
