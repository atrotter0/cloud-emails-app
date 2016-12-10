class Overrides
  attr_accessor :name, :internal_name, :urn, :status, :category, :subject, :from_name, :from_email, :to_name, :to_email, :greeting, :header_img, :header_bg, :body_style

  def initialize(name, internal_name, urn, status)
    @name = name
    @internal_name = internal_name
    @urn = urn
    @status = status
    @category = ""
    @subject = ""
    @from_name = ""
    @from_email = ""
    @to_name = ""
    @to_email = ""
    @greeting = ""
    @header_img = ""
    @header_bg = ""
    @body_style = ""
  end
end