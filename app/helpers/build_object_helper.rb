module BuildObjectHelper
  # Build our emails objects with hub data
  # add to our objects with cls data
  def build_object(client_urn, cls_url, arr)
    emails_arr = arr

    #get data from hub
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
    return emails_arr
  end
end