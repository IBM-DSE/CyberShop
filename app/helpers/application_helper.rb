module ApplicationHelper
  def company_name
    Rails.application.class.parent_name
  end
end
