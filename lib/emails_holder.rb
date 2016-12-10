class EmailsHolder

  include BuildObjectHelper

  attr_accessor :loc_name
  attr_accessor :loc_internal_name
  attr_accessor :loc_urn
  attr_accessor :loc_hub_emails
  attr_accessor :loc_cls_emails
  attr_accessor :loc_status

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

  def add_cls_email(email_val)
    @loc_cls_emails = @loc_cls_emails + " " + email_val
  end

end