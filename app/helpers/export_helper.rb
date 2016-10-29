module ExportHelper
	
	require 'csv'

	# create local csv
	# export data to csv
	def export_emails(file_name, arr)
		csv_headers = ["Location Name:", "Internal Branded Name:", "CLS emails:", "Hub Emails:"]
		CSV.open(file_name, "wb") do |csv|
			csv << csv_headers
		end
		i = 0
		while i < arr.length
			CSV.open(file_name, "a+") do |csv|
				formatted = []
				formatted.push(arr[i].get_name, arr[i].get_internal_name, arr[i].get_cls_emails, arr[i].get_hub_emails)
				csv << formatted
				i = i+1
			end
		end
	end
end