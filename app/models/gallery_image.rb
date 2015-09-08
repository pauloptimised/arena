class GalleryImage < ActiveRecord::Base
	
  acts_as_eskimagical
	
	belongs_to :gallery
  
	named_scope :position, :order => "position"
  named_scope :active, :conditions => ["recycled = ? AND display = ? AND date <= ?", false, true, Date.today]
  named_scope :recycled, :conditions => ["recycled = ?", true]
  named_scope :unrecycled, :conditions => ["recycled = ?", false]
  named_scope :gallery_id, lambda{|gallery_id| {:conditions => ["gallery_id = ?", gallery_id]} }
  
  has_attached_image :image, :styles => {:index => "99x99#", :show => "700"}
  has_images
  
  def active?
  	display? && !recycled?
  end
  
end
