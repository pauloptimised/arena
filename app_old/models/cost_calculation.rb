class CostCalculation < ActiveRecord::Base

	acts_as_eskimagical

	named_scope :position, :order => "position"
  named_scope :active, :conditions => ["recycled = ? AND display = ?", false, true]
  named_scope :recycled, :conditions => ["recycled = ?", true]
  named_scope :unrecycled, :conditions => ["recycled = ?", false]
  
  validates_presence_of :name, :email, :phone

  def active?
  	display? && !recycled?
  end
  
  # External Assumptions
  def annual_working_days
    232.0
  end
  
  def phone_call_cost_per_minute
    0.1
  end
  
  def print_copy_and_post_cost
    1.0
  end
  
  def external_document_storage_cost
    0.03
  end
  
  def staff_hourly_salary
    12.0
  end
  
  def time_to_file_a_paper_document
    0.01
  end
  
  def time_to_retrieve_a_paper_document
    0.04
  end
  
  def time_to_approve_a_paper_document
    0.04
  end
  
  def time_to_call_back
    0.06
  end
  
  # mstore Constants
  def time_to_file_a_mstore_document
    0.0085
  end
  
  def time_to_retrieve_a_mstore_document
    0.01
  end
  
  def time_to_approve_a_mstore_document
    0.01
  end
  
  # Calculations
  def archiving_and_retrieval_saving
    [
      self.document_archive_count * self.time_to_file_a_paper_document * self.annual_working_days * self.staff_hourly_salary,
      self.document_retrieval_count * self.time_to_retrieve_a_paper_document * self.annual_working_days * self.staff_hourly_salary,
      (self.document_callbacks_count * self.time_to_call_back * self.annual_working_days * self.staff_hourly_salary) + (self.document_callbacks_count * self.annual_working_days * self.phone_call_cost_per_minute),
      self.document_archive_count * self.annual_working_days * self.external_document_storage_cost 
    ].sum - [ 
      self.document_archive_count * self.time_to_file_a_mstore_document * self.annual_working_days * self.staff_hourly_salary,
      self.document_retrieval_count * self.time_to_retrieve_a_mstore_document * self.annual_working_days * self.staff_hourly_salary,
      ((self.document_archive_count * self.annual_working_days) / 30000) * 2 # Not sure what the 30000 or the 2 are meant to represent at this point. Taken directly from supplied spreadsheet.
    ].sum
  end
  
  def distribution_saving
    self.document_distribution_count * self.print_copy_and_post_cost * self.annual_working_days * 0.9 # The spreadsheet also implied that the user would always save 90% on distribution.
  end
  
  def processing_saving
    (self.document_process_count * self.time_to_approve_a_paper_document * self.annual_working_days * self.staff_hourly_salary) - (self.document_process_count * self.time_to_approve_a_mstore_document * self.annual_working_days * self.staff_hourly_salary)
  end
  
  def total_saving
    self.archiving_and_retrieval_saving + self.distribution_saving + self.processing_saving
  end

end
