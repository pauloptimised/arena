class Category < ActiveRecord::Base
	
	acts_as_eskimagical
  
	named_scope :position, :order => "position"
  named_scope :active, :conditions => ["recycled = ? AND display = ?", false, true]
  named_scope :recycled, :conditions => ["recycled = ?", true]
  named_scope :unrecycled, :conditions => ["recycled = ?", false]
  
  has_many :products
  
  has_attached_image :image, :styles => {:index => "150"}
  has_images
  
  def active?
  	display? && !recycled?
  end
  
end
