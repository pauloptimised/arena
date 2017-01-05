module PageContentsHelper

  def basic
    # Testimonials
    # @testimonials = Testimonial.active.random.tagged_with(@page_node.active_content.subscriptions, :any => true)
    # unless @testimonials.empty?
    #   @testimonial = @testimonials.first
    # else
    #   @testimonial = Testimonial.active.highlighted.random.first
    #   @testimonial ||= Testimonial.active.random.first
    # end
    # Case Studies
    if @page_node.is_a_service?
      @case_studies = CaseStudy.active.highlighted.random.select{|x| x.service && (@page_node.eql?(x.service))}
    elsif @page_node.parent.is_a_service?
      @case_studies = CaseStudy.active.highlighted.random.select{|x| x.service && (@page_node.parent.eql?(x.service))}
    else
      @case_studies = CaseStudy.active.highlighted.random.tagged_with(@page_node.active_content.subscriptions, :any => true)
    end
    if !@page_node.active_content.case_studies.blank?
      @case_study = @page_node.active_content.case_studies.random.first
    elsif !@case_studies.empty?
      @case_study = @case_studies.first
    end
    
    # Other
    @jobs = Job.active
    @staff_testimonials = StaffTestimonial.random(3)
    @survey = Survey.find(:first, :order => 'RAND()')
  end

  def copy_and_print
    # Case Studies
    if @page_node.is_a_service?
      @case_studies = CaseStudy.active.highlighted.random.select{|x| x.service && (@page_node.eql?(x.service))}
    elsif @page_node.parent.is_a_service?
      @case_studies = CaseStudy.active.highlighted.random.select{|x| x.service && (@page_node.parent.eql?(x.service))}
    else
      @case_studies = CaseStudy.active.highlighted.random.tagged_with(@page_node.active_content.subscriptions, :any => true)
    end
    if !@page_node.active_content.case_studies.blank?
      @case_study = @page_node.active_content.case_studies.random.first
    elsif !@case_studies.empty?
      @case_study = @case_studies.first
    end
    # Other
    @jobs = Job.active
    @staff_testimonials = StaffTestimonial.random(3)
    @survey = Survey.find(:first, :order => 'RAND()')
  end

  def edm
    # Case Studies
    if @page_node.is_a_service?
      @case_studies = CaseStudy.active.highlighted.random.select{|x| x.service && (@page_node.eql?(x.service))}
    elsif @page_node.parent.is_a_service?
      @case_studies = CaseStudy.active.highlighted.random.select{|x| x.service && (@page_node.parent.eql?(x.service))}
    else
      @case_studies = CaseStudy.active.highlighted.random.tagged_with(@page_node.active_content.subscriptions, :any => true)
    end
    if !@page_node.active_content.case_studies.blank?
      @case_study = @page_node.active_content.case_studies.random.first
    elsif !@case_studies.empty?
      @case_study = @case_studies.first
    end
    
    # Other
    @jobs = Job.active
    @staff_testimonials = StaffTestimonial.random(3)
    @survey = Survey.find(:first, :order => 'RAND()')
  end
  
  def community
    @galleries = Gallery.active.position
    @community_news = Article.active.tagged_with("Arena in the Community")
  end

  def green_arena
    @green_arena_texts = GreenArenaText.active.position
  end

  def none

  end

  def resources
    @surveys = Survey.active.position[0..11]
    @testimonial = Testimonial.active.random.first
  end

  def document
    
  end

end
