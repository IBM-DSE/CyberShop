
class Company
  def self.name
    Rails.application.class.parent_name
  end

  def self.description
    "The World's Smartest Devices"
  end
end
