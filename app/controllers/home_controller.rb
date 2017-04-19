class HomeController < ApplicationController
  include ResponseHelper
  include DataHelper
  include BuildObjectHelper
  include ExportHelper
  include GetOverridesHelper

  def index
  end

  def check_params
    email_cls_urn = params[:email_cls_urn]
    override_cls_urn = params[:override_cls_urn] 
    # validate and run export depending on params passed
    if email_cls_urn.blank? != true
      run_emails_export email_cls_urn
    elsif override_cls_urn.blank? != true
      run_overrides_export override_cls_urn
    else
      trigger_redirect
    end
  end
end