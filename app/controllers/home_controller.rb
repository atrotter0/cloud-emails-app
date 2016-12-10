class HomeController < ApplicationController
  include ResponseHelper
  include DataHelper
  include BuildObjectHelper
  include ExportHelper

  def index

  end

  def run_export
    cls_urn = params[:cls_urn]
    email_list = []
    # validate for empty input field on form submit
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
        email_list = build_object client_urn, cls_url, email_list
        start_export "#{client_urn}_cloud_emails.csv", email_list
        puts "Emails exported!"
      end
    end
  end
end