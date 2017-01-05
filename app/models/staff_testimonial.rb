class StaffTestimonial < ActiveRecord::Base
	
  acts_as_eskimagical
	acts_as_taggable_on :tags
	
	validates_presence_of :quote, :author
  
	named_scope :position, :order => "position"
  named_scope :active, :conditions => ["recycled = ? AND display = ?", false, true]
  named_scope :recycled, :conditions => ["recycled = ?", true]
  named_scope :unrecycled, :conditions => ["recycled = ?", false]
  named_scope :randomised, :order => "RAND()"
  
  def active?
  	display? && !recycled?
  end
  
  def name
    author
  end
  
  def summary
    quote
  end
  
  def self.random(count=1)
    if count > 1
      self.randomised.active[0..(count-1)]
    else
      self.randomised.active
    end
  end
  
end
