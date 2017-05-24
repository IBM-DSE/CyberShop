module ApplicationHelper
  def company_name
    Rails.application.class.parent_name
  end

  def company_description
    "The World's Smartest Devices"
  end
end
