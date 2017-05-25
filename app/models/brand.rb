class Brand < ApplicationRecord
  has_many :products

  def to_param
    name
  end
end
