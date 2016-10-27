class HomeController < ApplicationController

	require 'csv'
	
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

	# Grab response from the cls API
	# Set flag and return flag to trigger next method
	def get_response(url)
		res_flag = false
		response = RestClient.get(url){|response, request, result| response 
			if response.code != 200
				puts response.code
				res_flag = true
				puts "Skipped due to #{response.code}"
			end
		}
		return res_flag
	end

	def trigger_redirect
		redirect_to "/", notice: "Please enter a valid CLS urn."
	end

	# Get and return cls data if response is valid
	def get_data(flag, url)
		data = ""
		response = RestClient.get(url)
		data = JSON.load response
		return data
	end

	# get client_urn
	def get_client_urn(base_url)
		client_urn = ""
		data = get_data response, base_url
		client_urn = data["configurable_attributes"][0]["client_urn"]
		return client_urn
	end

	# Build our emails objects with hub data
	# add to our objects with cls data
	# export data to csv
	def build_object(client_urn, cls_url)
		# array used for data export
		emails_arr = []
		# get data from the hub api
		hub_url = "http://hub.g5dxm.com/clients/#{client_urn}.json"
		hub_response = get_response hub_url
		hub_data = get_data hub_response, hub_url
		# get data from cls api
		cls_response = get_response cls_url
		cls_data = get_data cls_response, cls_url
		# build objects with hub data
		hub_data["client"]["locations"].each do |loc|
			# grab locations that are not deleted or suspended
				email_obj = Emails.new(loc["name"], loc["internal_branded_name"], loc["urn"], loc["email"], loc["status"])
				# variables for matching cls data
				my_string = ""
				match_val = -1
				cls_emails = ""
				# add cls data to existing objects
				cls_data["configurable_attributes"].each do |item|
					# add to existing object if location urns are the same
					if item["category"] == "Location" && item["location_urn"] == email_obj.get_loc_urn && item["field"] == "to_email"
					# only push values that are emails
					my_string = item["value"]
					match_val = /@/ =~ my_string
						if match_val == nil
							# puts "nil: not a valid value"
						elsif match_val >= 0
							email_obj.add_cls_email(item["value"])
						end
					end
				end
			# only push objects that are live or pending status
			if email_obj.get_status != "Deleted" && email_obj.get_status != "Suspended"
				emails_arr.push(email_obj)
			end
		end
		# run export to csv method
		export_emails "#{client_urn}_cloud_emails.csv", emails_arr
		puts "Emails exported!"
	end

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

  def index

  end

  def emails_export
  	cls_urn = params[:cls_urn]
  	# validate for no user entry
  	if cls_urn.empty?
  		trigger_redirect
  	else
			cls_url = "https://#{cls_urn}.herokuapp.com/api/v1/configurable_attributes"
			puts "Gathering data for #{cls_urn}..."
			response = get_response cls_url
			# check for invalid response
			if response
				trigger_redirect
			else
				client_urn = get_client_urn cls_url
				build_object client_urn, cls_url
			end
		end
  end

end