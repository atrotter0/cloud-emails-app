class Emails
  attr_accessor :loc_name, :loc_internal_name, :loc_urn, :loc_hub_emails, :loc_cls_emails, :loc_status,
                :loc_form_emails

  def initialize(name, internal_name, urn, emails, status)
    @loc_name = name
    @loc_internal_name = internal_name
    @loc_urn = urn
    @loc_hub_emails = emails
    @loc_cls_emails = ""
    @loc_form_emails = ""
    @loc_status = status
  end

  def display
    puts "Name: #{@loc_name}"
    puts "Internal Name: #{@loc_internal_name}"
    puts "URN: #{@loc_urn}"
    puts "Hub Emails: #{@loc_hub_emails}"
    puts "CLS Emails: #{@loc_cls_emails}"
    puts "CLS Form Emails: #{@loc_form_emails}"
    puts "Status: #{@loc_status}"
  end

  def add_cls_email(email_val)
    @loc_cls_emails = @loc_cls_emails + " " + email_val
  end

  def add_form_email(email)
    @loc_form_emails = @loc_form_emails + email
  end

  def remove_last_comma
    @loc_form_emails = @loc_form_emails.chop.chop
  end
end
