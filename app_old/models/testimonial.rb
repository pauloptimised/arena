class Testimonial < ActiveRecord::Base
	
  acts_as_eskimagical
	acts_as_taggable_on :tags
	
	validates_presence_of :quote
  
	named_scope :position, :order => "position"
  named_scope :active, :conditions => ["recycled = ? AND display = ?", false, true]
  named_scope :recycled, :conditions => ["recycled = ?", true]
  named_scope :unrecycled, :conditions => ["recycled = ?", false]
  named_scope :random, :order => 'RAND()'
  named_scope :highlighted, :conditions => ["highlight = ?", true]
  named_scope :with_service, lambda{|service| {:conditions => ["service_id = ?", service]}}
  
  has_attached_image :image, :styles => {:index => "200x136#", :banner => "496x280#"}
  has_images
  
  belongs_to :service, :class_name => "PageNode"
  has_one :case_study
  
  def active?
  	display? && !recycled?
  end
  
  def name
    author
  end
  
  def summary
    quote
  end
  
  def short_quote
    if quote.length > 130
      quote[0..130].split[0..-2].join(" ") + "..."
    else
      quote
    end
  end
  
  def self.highlight
    self.active.find(:first, :order => 'RAND()', :conditions => ["highlight = ?", true])
  end
  
end
