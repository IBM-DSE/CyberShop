module ApplicationHelper
  def company_name
    Rails.application.class.parent_name
  end

  def company_description
    "The World's Smartest Devices"
  end

  def home_page
    controller_name == 'company' && action_name == 'home'
  end
end
