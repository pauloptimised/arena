class CaseStudy < ActiveRecord::Base

	has_friendly_id :name, :use_slug => true

  acts_as_eskimagical
	acts_as_taggable_on :tags

	named_scope :position, :order => "position"
  named_scope :active, :conditions => ["recycled = ? AND display = ?", false, true]
  named_scope :recycled, :conditions => ["recycled = ?", true]
  named_scope :unrecycled, :conditions => ["recycled = ?", false]
  named_scope :random, :order => 'RAND()'
  named_scope :highlighted, :conditions => ["highlight = ?", true]
  named_scope :with_service, lambda{|service| {:conditions => ["service_id = ?", service]}}

  belongs_to :service, :class_name => "PageNode"
  belongs_to :testimonial
  belongs_to :page_content

  has_attached_image :image, :styles => {:index => "200x136#", :show => "300x204#", :customers => "132x90#", :top_area => "496x280#"}
  has_images

  may_contain_images :main_content

  def active?
  	display? && !recycled?
  end

  def self.highlight
    self.active.find(:first, :order => 'RAND()', :conditions => ["highlight = ?", true])
  end

end
