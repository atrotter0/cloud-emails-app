class Emails
	def initialize(name, internal_name, urn, emails, status)
		@loc_name = name
		@loc_internal_name = internal_name
		@loc_urn = urn
		@loc_hub_emails = emails
		@loc_cls_emails = ""
		@loc_status = status
	end

	def display
		puts "Name: #{@loc_name}"
		puts "Internal Name: #{@loc_internal_name}"
		puts "URN: #{@loc_urn}"
		puts "Hub Emails: #{@loc_hub_emails}"
		puts "CLS Emails: #{@loc_cls_emails}"
		puts "Status: #{@loc_status}"
	end

	#getters
	def get_loc_urn
		return @loc_urn
	end

	def get_name
		return @loc_name
	end

	def get_internal_name
		return @loc_internal_name
	end

	def get_hub_emails
		return @loc_hub_emails
	end

	def get_cls_emails
		return @loc_cls_emails
	end

	def add_cls_email(email_val)
		@loc_cls_emails = @loc_cls_emails + " " + email_val
	end

	def get_status
		return @loc_status
	end
end