class Mailer < ActionMailer::Base

	add_template_helper ApplicationHelper

  def let_the_board_know(name, tel, email, message)
    @subject           = "Let the board know form completed - #{SiteSetting.like("Site Name").first.value}"
    @from              = email
    @recipients        = SiteSetting.like("Email (Let the board know)").first.value
    @cc                = "lisab@arenagroup.net"
    @body[:name]       = name
    @body[:tel]        = tel
    @body[:email]      = email
    @body[:message]    = message
    content_type "text/html"
  end

  def duplicate_invoice_request(i_number, email)
    @subject           = "Duplicate invoice requested - #{SiteSetting.like("Site Name").first.value}"
    @from              = email
    @recipients        = SiteSetting.like("Email (Duplicate invoice request A)").first.value
    @cc                = "lisab@arenagroup.net"
    @cc                = SiteSetting.like("Email (Duplicate invoice request B)").first.value
    @body[:i_number]   = i_number
    @body[:email]      = email
    content_type "text/html"
  end

	def contact_us(name, email, tel, enquiry, postcode, product, form)
    unless form.blank?
      @subject = "Contact Us Form ('#{form}') Completed - #{SiteSetting.like("Site Name").first.value}"
    else
      @subject = "Contact Us Form Completed - #{SiteSetting.like("Site Name").first.value}"
    end
    @from              = email
    @recipients        = SiteSetting.like("Email").first.value
    @cc                = "lisab@arenagroup.net"
    @body[:enquiry]    = enquiry
    @body[:name]       = name
    @body[:email]      = email
    @body[:tel]        = tel
    @body[:product]    = product
    @body[:postcode]   = postcode
    content_type "text/html"
  end

	def let_the_boss_know(name, email, tel, enquiry)
    @subject           = "Contact Us Form Completed - #{SiteSetting.like("Site Name").first.value}"
    @from              = email
    @recipients        = SiteSetting.like("Boss Email").first.value
    @cc                = "lisab@arenagroup.net"
    @body[:enquiry]    = enquiry
    @body[:name]       = name
    @body[:email]      = email
    @body[:tel]        = tel
    content_type "text/html"
	end

	def document_audit_request(name, company, email, phone)
	  email = SiteSetting.like("Site Name").first.value if email.blank?
	  name = 'Somebody' if name.blank?
    @subject           = "Document Audit Requested - #{SiteSetting.like("Site Name").first.value}"
    @from              = email
    @recipients        = SiteSetting.like("Email (Document Audit Request)").first.value
    @cc                = "lisab@arenagroup.net"
    @body[:name]       = name
    @body[:company]    = company
    @body[:email]      = email
    @body[:phone]      = phone
    content_type "text/html"
  end

  def print_audit_request(name, company, email, phone)
	  email = SiteSetting.like("Site Name").first.value if email.blank?
	  name = 'Somebody' if name.blank?
    @subject           = "Print Audit Requested - #{SiteSetting.like("Site Name").first.value}"
    @from              = email
    @recipients        = SiteSetting.like("Email (Print Audit Request)").first.value
    @cc                = "lisab@arenagroup.net"
    @body[:name]       = name
    @body[:company]    = company
    @body[:email]      = email
    @body[:phone]      = phone
    content_type "text/html"
  end

	def results(results, name, message, forwarder, recipient, calculation_id)
    @subject           = "Look how much we could save with mstore"
    @from              = forwarder
    @recipients        = recipient
		part(:content_type => "multipart/alternative") do |p|
			p.part :content_type => "text/html", :body => render_message("results", :name => name, :message => message, :results => results)
		end
		attachment(:content_type => "application/pdf",
			:filename => "Report.pdf",
			:body => File.read("#{RAILS_ROOT}/public/cost_calculations/#{calculation_id}.pdf")
		)
	end

	def callback_request(calculation_id, name, tel)
    @subject           = "Callback request completed - #{SiteSetting.like("Site Name").first.value}"
    @from              = SiteSetting.like("Email").first.value
    @recipients        = SiteSetting.like("Email").first.value
    @cc                = "lisab@arenagroup.net"
    @body[:id]         = calculation_id
    @body[:name]       = name
    @body[:tel]        = tel
    content_type "text/html"
	end

	def cost_calculation(cost_calculation)
	  @subject           = "Cost calculation form completed - #{SiteSetting.like("Site Name").first.value}"
	  @from              = SiteSetting.like("Email").first.value
	  @recipients        = SiteSetting.like("Email (Cost Calculation alert)").first.value
	  @cc                = "lisab@arenagroup.net"
	  @body[:ddc]        = cost_calculation.document_distribution_count
	  @body[:dac]        = cost_calculation.document_archive_count
	  @body[:drc]        = cost_calculation.document_retrieval_count
	  @body[:dcc]        = cost_calculation.document_callbacks_count
	  @body[:dpc]        = cost_calculation.document_process_count
	  @body[:name]       = cost_calculation.name
	  @body[:email]      = cost_calculation.email
	  @body[:phone]      = cost_calculation.phone
	  content_type "text/html"
	end

  def newsletter_subscription(email)
    @subject           = "Newsletter subscription - #{SiteSetting.like("Site Name").first.value}"
    @from              = SiteSetting.like("Email (Newsletter Subscription)").first.value
    @recipients        = SiteSetting.like("Email (Newsletter Subscription)").first.value
    @cc                = "lisab@arenagroup.net"
    @body[:email]      = email
    content_type "text/html"
  end

  def request_a_review(name, email, tel, company_name, business_size, enquiry, form, post_code)
    unless form.blank?
      @subject = "#{form} Form Completed - #{SiteSetting.like("Site Name").first.value}"
    else
      @subject = "Request A Review Form Completed - #{SiteSetting.like("Site Name").first.value}"
    end
    @from              = email
    @recipients        = "marketing@arenagroup.net"#"james@eskimosoup.co.uk"#
    @body[:enquiry]    = enquiry
    @body[:name]       = name
    @body[:email]      = email
    @body[:tel]        = tel
    @body[:company_name]  = company_name
    @body[:post_code]  = post_code
    @body[:business_size] = business_size
    @body[:form] = form
    content_type "text/html"
  end

  def demon_printers(name, email, phone, company_name, business_size, enquiry, form, post_code)
    unless form.blank?
      @subject = "#{form} Form Completed - #{SiteSetting.like("Site Name").first.value}"
    else
      @subject = "Demon Printers Form Completed - #{SiteSetting.like("Site Name").first.value}"
    end
    @from              = email
    @recipients        = "marketing@arenagroup.net"#"ade@eskimosoup.co.uk"
    @body[:enquiry]    = enquiry
    @body[:name]       = name
    @body[:email]      = email
    @body[:phone]        = phone
    @body[:company_name]  = company_name
    @body[:post_code]  = post_code
    @body[:business_size] = business_size
    @body[:form] = form
    content_type "text/html"
  end

end
