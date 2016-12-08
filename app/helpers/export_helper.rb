module ExportHelper
	
  require 'csv'

  def start_export(file_name, arr)
    send_data(export_emails(file_name, arr), :type => 'text/csv; charset=utf-8; header=present', :filename => file_name)
  end

  def export_emails(file_name, arr)
    csv_headers = ["Location Name:", "Internal Branded Name:", "CLS emails:", "Hub Emails:"]
    CSV.generate do |csv|
      csv << csv_headers
      arr.each do |item|
        formatted = []
        formatted.push(item.get_name, item.get_internal_name, item.get_cls_emails, item.get_hub_emails)
        csv << formatted
      end
    end
  end
end