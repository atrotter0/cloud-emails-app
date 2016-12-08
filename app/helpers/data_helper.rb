module DataHelper
  
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
end