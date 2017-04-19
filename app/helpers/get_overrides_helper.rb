module GetOverridesHelper
  # get overrides for specific emailer category
  # add values to object if they match all cls API values
  # return object
  def get_overrides(item, obj, category, arr)
    # location overrides
    if category == "Location"
      obj.category = item["category"]
      if item["category"] == "Location" && item["location_urn"] == obj.urn && item["field"] == "subject"
        obj.subject = item["value"]
      elsif item["category"] == "Location" && item["location_urn"] == obj.urn && item["field"] == "from_name"
        obj.from_name = item["value"]
      elsif item["category"] == "Location" && item["location_urn"] == obj.urn && item["field"] == "from_email"
        obj.from_email = item["value"]
      elsif item["category"] == "Location" && item["location_urn"] == obj.urn && item["field"] == "to_name"
        obj.to_name = item["value"]
      elsif item["category"] == "Location" && item["location_urn"] == obj.urn && item["field"] == "greeting_paragraph"
        obj.greeting = item["value"]
      elsif item["category"] == "Location" && item["location_urn"] == obj.urn && item["field"] == "header_image_url"
        obj.header_img = item["value"]
      elsif item["category"] == "Location" && item["location_urn"] == obj.urn && item["field"] == "header_background_color"
        obj.header_bg = item["value"]
      elsif item["category"] == "Location" && item["location_urn"] == obj.urn && item["field"] == "body_style"
        obj.body_style = item["value"]
      end
    # customer overrides
    else
      obj.category = item["category"]
      if item["category"] == "Customer" && item["location_urn"] == obj.urn && item["field"] == "subject"
        obj.subject = item["value"]
      elsif item["category"] == "Customer" && item["location_urn"] == obj.urn && item["field"] == "from_name"
        obj.from_name = item["value"]
      elsif item["category"] == "Customer" && item["location_urn"] == obj.urn && item["field"] == "from_email"
        obj.from_email = item["value"]
      elsif item["category"] == "Customer" && item["location_urn"] == obj.urn && item["field"] == "to_name"
        obj.to_name = item["value"]
      elsif item["category"] == "Customer" && item["location_urn"] == obj.urn && item["field"] == "reply_to_email"
        obj.to_email = item["value"]
      elsif item["category"] == "Customer" && item["location_urn"] == obj.urn && item["field"] == "greeting_paragraph"
        obj.greeting = item["value"]
      elsif item["category"] == "Customer" && item["location_urn"] == obj.urn && item["field"] == "header_image_url"
        obj.header_img = item["value"]
      elsif item["category"] == "Customer" && item["location_urn"] == obj.urn && item["field"] == "header_background_color"
        obj.header_bg = item["value"]
      elsif item["category"] == "Customer" && item["location_urn"] == obj.urn && item["field"] == "body_style"
        obj.body_style = item["value"]
      end
    end
    return obj
  end
end