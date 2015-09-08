class Product < ActiveRecord::Base
	
	acts_as_eskimagical
  
	named_scope :position, :order => "position"
  named_scope :active, :conditions => ["recycled = ? AND display = ?", false, true]
  named_scope :recycled, :conditions => ["recycled = ?", true]
  named_scope :unrecycled, :conditions => ["recycled = ?", false]
  
  belongs_to :make
  belongs_to :category
  
  has_attached_image :image, :styles => {:index => "200"}
  has_attached_document :datasheet
  
  has_images
  has_documents
  
  may_contain_images :description
  may_contain_documents :description
  
  def active?
  	display? && !recycled?
  end
  
  def self.highlight
    self.active.find(:first, :order => 'RAND()', :conditions => ["highlight = ?", true])
  end
  
end
