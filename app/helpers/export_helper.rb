module ExportHelper

  def run_emails_export(urn)
    email_list = []
    cls_url = "https://#{urn}.herokuapp.com/api/v1/configurable_attributes"
    puts "Gathering data for #{urn}..."
    response = get_response cls_url

    # check for invalid response
    if response
      trigger_redirect
    else
      client_urn = get_client_urn cls_url
      email_list = build_emails_object client_urn, cls_url, email_list
      start_emails_export "#{urn}_emails.csv", email_list
      puts "Emails exported!"
    end
  end

  def run_overrides_export(urn)
    override_list = []
    loc_overrides = []
    cust_overrides = []
    cls_url = "https://#{urn}.herokuapp.com/api/v1/configurable_attributes"
    puts "Gathering data for #{urn}..."
    response = get_response cls_url

    # check for invalid response
    if response
      trigger_redirect
    else
      client_urn = get_client_urn cls_url
      override_list = build_overrides_object client_urn, cls_url, override_list
      # push location override obj to export array
      loc_overrides.push(override_list[0])
      # push customer override obj array to export array
      cust_overrides.push(override_list[1])
      start_overrides_export  "#{urn}_overrides.csv", loc_overrides, cust_overrides
      puts "Overrides exported!"
    end
  end
  
  def start_emails_export(file_name, arr)
    send_data(export_emails(file_name, arr), :type => 'text/csv; charset=utf-8; header=present', :filename => file_name)
  end

  def start_overrides_export(file_name, arr_1, arr_2)
    send_data(export_overrides(file_name, arr_1, arr_2), :type => 'text/csv; charset=utf-8; header=present', :filename => file_name)
  end

  def export_emails(file_name, arr)
    csv_headers = ["Location Name:", "Internal Branded Name:", "CLS emails:", "Hub Emails:"]
    CSV.generate do |csv|
      csv << csv_headers
      arr.each do |item|
        formatted = []
        formatted.push(item.loc_name, item.loc_internal_name, item.loc_cls_emails, item.loc_hub_emails)
        csv << formatted
      end
    end
  end

  def export_overrides(file_name, arr_1, arr_2)
  csv_headers = ["Location Name:", "Internal Branded Name:", "Category:", "subject:", "from_name:", "from_email:", "to_name:", "to_email:", "greeting:", "header_img", "header_bg:", "body_style:"]
    CSV.generate do |csv|
      csv << csv_headers
      # export category arrays to csv
      push_category_to_csv csv, arr_1
      push_category_to_csv csv, arr_2
    end
  end

  def push_category_to_csv(csv, arr)
    arr.each do |item|
      item.each do |pos|
        formatted = []
        formatted.push(pos.name, pos.internal_name, pos.category, pos.subject, pos.from_name, pos.from_email, pos.to_name, pos.to_email, pos.greeting, pos.header_img, pos.body_style)
        csv << formatted
      end
    end
  end
end