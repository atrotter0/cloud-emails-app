module ResponseHelper
  
  # Get response from the cls API
  # Set flag and return flag so we know if response is valid (F) or invalid (T)
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
end