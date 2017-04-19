module BuildObjectHelper
  # Build our emails objects with hub data
  # add to our objects with cls data
  def build_emails_object(client_urn, cls_url, arr)
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
      # add cls data to existing objects
      cls_data["configurable_attributes"].each do |item|
        # add to existing object if location urns are the same
        if item["category"] == "Location" && item["location_urn"] == email_obj.loc_urn && item["field"] == "to_email" && item["value"].include?("@")
          if item.has_key?("form")
            form_and_email = item["form"] + ": " + item["value"] + ", "
            email_obj.add_form_email(form_and_email)
          else
            email_obj.add_cls_email(item["value"])
          end
        end
      end

      # only push objects that are not deleted, or suspended
      if email_obj.loc_status != "Deleted" && email_obj.loc_status != "Suspended"
        email_obj.remove_last_comma
        emails_arr.push(email_obj)
      end
    end
    return emails_arr
  end

  # Build our overrides object with hub data
  # add to our object with cls data
  # return array of cls override obj
  def build_overrides_object(client_urn, cls_url, arr)
    # array used for data export
    loc_overrides_arr = []
    cust_overrides_arr = []
    
    # get data from the hub api
    hub_url = "http://hub.g5dxm.com/clients/#{client_urn}.json"
    hub_response = get_response hub_url
    hub_data = get_data hub_response, hub_url
    
    # get data from cls api
    cls_response = get_response cls_url
    cls_data = get_data cls_response, cls_url

    # build objects with hub data
    hub_data["client"]["locations"].each do |loc|
      loc_overrides_obj = Overrides.new(loc["name"], loc["internal_branded_name"], loc["urn"], loc["status"])
      cust_overrides_obj = Overrides.new(loc["name"], loc["internal_branded_name"], loc["urn"], loc["status"])
      
      # add cls API override data to existing objects
      cls_data["configurable_attributes"].each do |item|
        # seperate by category
        if item["category"] == "Location"
          # run get_overrides with specific category
          loc_overrides_obj = get_overrides item, loc_overrides_obj, "Location", loc_overrides_arr  
        elsif item["category"] == "Customer"
          cust_overrides_obj = get_overrides item, cust_overrides_obj, "Customer", cust_overrides_arr
        end
      end

      # push override objs to arrays
      if loc_overrides_obj.status != "Deleted" && loc_overrides_obj.status != "Suspended" && cust_overrides_obj.status != "Deleted" && cust_overrides_obj.status != "Suspended"
        loc_overrides_arr.push(loc_overrides_obj)
        cust_overrides_arr.push(cust_overrides_obj)
      end
      arr.push(loc_overrides_arr)
      arr.push(cust_overrides_arr)
    end
    # return array of objects
    return arr
  end
end