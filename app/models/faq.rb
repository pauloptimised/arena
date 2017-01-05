class Faq < ActiveRecord::Base
	
  acts_as_eskimagical
	acts_as_taggable_on :tags
  
	named_scope :position,    :order => "position"
  named_scope :active,      :conditions => ["recycled = ? AND display = ?", false, true]
  named_scope :recycled,    :conditions => ["recycled = ?", true]
  named_scope :unrecycled,  :conditions => ["recycled = ?", false]
  named_scope :seo_pap,     :conditions => ["category = ?", "Photocopiers and Printers"]
  named_scope :seo_edm,     :conditions => ["category = ?", "Electronic Document Management"]
  named_scope :seo_mds,     :conditions => ["category = ?", "Managed Print Service"]
  named_scope :seo_edm_for, :conditions => ["category = ?", "EDM for Storing, Protecting and Retrieving Critical Documents"]
  
  def active?
  	display? && !recycled?
  end
  
  def name
    question
  end
  
  def summary
    answer
  end
  
  def self.categories
    ["Photocopiers and Printers", "Electronic Document Management", "Managed Print Service", "EDM for Storing, Protecting and Retrieving Critical Documents"]
  end
  
end
