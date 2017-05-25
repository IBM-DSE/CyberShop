class Category < ApplicationRecord
  has_many :products

  def to_param
    name
  end
end
